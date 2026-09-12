import {chromium} from '../../tools/runtime-options/dirplayer-rs/node_modules/playwright/index.mjs';
import fs from 'node:fs/promises';
import path from 'node:path';
import {createHash} from 'node:crypto';

const base=process.env.FINDUS_TEST_URL || 'http://127.0.0.1:8766/';
const output=path.resolve('artifacts/runtime-tests/web/late-days');
await fs.mkdir(output,{recursive:true});
const movies=process.argv.slice(2);
const targets=movies.length ? movies : [...Array.from({length:12},(_,i)=>`DAG${String(i+13).padStart(2,'0')}`),'KONSTR01','KONSTR02','KONSTR03'];
const browser=await chromium.launch({headless:true});
const reports=[];
const engineSha256=createHash('sha256').update(await fs.readFile('dist/web/engine/vm_rust_bg.wasm')).digest('hex');
for(const movie of targets){
  const page=await browser.newPage({viewport:{width:1000,height:800}});
  page.setDefaultTimeout(12000);
  const report={movie,engineSha256,startedAt:new Date().toISOString(),events:[],checkpoints:[],actions:[]};
  const cdp=await page.context().newCDPSession(page);
  await cdp.send('Debugger.enable');
  cdp.on('Debugger.paused',event=>{
    report.paused_stack=event.callFrames.slice(0,20).map(f=>({name:f.functionName,url:f.url,location:f.location}));
    console.log(`${movie}: blocked browser stack ${JSON.stringify(report.paused_stack)}`);
  });
  page.on('pageerror',e=>report.events.push({type:'pageerror',message:String(e)}));
  page.on('console',m=>{if(m.type()==='error')report.events.push({type:'console',message:m.text()});});
  try{
    await page.goto(`${base}?movie=${movie}`);
    await page.waitForFunction(()=>window.findus?.state.ready);
    await page.locator('#start').click();
    await page.waitForTimeout(1400);
    const stage=page.locator('#stage_canvas_container');
    async function click(x,y){
      const b=await stage.boundingBox();
      report.actions.push({type:'click',x,y});
      console.log(`${movie}: moving pointer to ${x},${y}`);
      await page.mouse.move(b.x+b.width*x/640,b.y+b.height*y/480);
      console.log(`${movie}: pointer down`);
      await page.mouse.down();await page.waitForTimeout(100);await page.mouse.up();
      console.log(`${movie}: pointer up complete`);
    }
    async function checkpoint(name){
      console.log(`${movie}: snapshot ${name}`);
      const snapshot={};
      for (const [key,api] of [['context','mcp_get_context'],['execution','mcp_get_execution_state'],['globals','mcp_get_globals']]) {
        let guard;
        try{
          snapshot[key]=await Promise.race([page.evaluate(api=>JSON.parse(window.findus.vm[api]()),api),new Promise((_,reject)=>{guard=setTimeout(()=>reject(new Error(`${name} ${key} did not respond within 12 seconds`)),12000);})]);
        }catch(error){
          await cdp.send('Debugger.pause');await page.waitForTimeout(250);
          report.paused_context=await cdp.send('Runtime.evaluate',{expression:'JSON.stringify({context:JSON.parse(window.findus.vm.mcp_get_context()),locals:JSON.parse(window.findus.vm.mcp_get_locals(1)),globals:JSON.parse(window.findus.vm.mcp_get_globals())})',returnByValue:true});
          console.log(`${movie}: paused context ${JSON.stringify(report.paused_context)}`);
          throw error;
        }
        finally{clearTimeout(guard);}
        console.log(`${movie}: ${name} ${key} captured`);
      }
      Object.assign(snapshot,await page.evaluate(()=>({errors:window.findus.state.errors,movie:window.findus.state.movie,loads:window.findus.state.loads})));
      snapshot.stage=await page.evaluate(()=>window.findus.vm.get_stage_snapshot ? JSON.parse(window.findus.vm.get_stage_snapshot()) : null);
      report.checkpoints.push({name,snapshot});
      await stage.screenshot({path:path.join(output,`${movie}-${name}.png`)});
      console.log(`${movie}: ${name} image captured`);
    }
    await checkpoint('intro');
    // First gesture can skip the spoken introduction; the second activates
    // the authored Spielen control when that first click only skipped speech.
    await click(420,460);await page.waitForTimeout(700);
    if(process.env.FINDUS_SINGLE_CLICK!=='1') await click(420,460);
    await page.waitForTimeout(movie==='DAG13'?8500:2500);
    await checkpoint('play');
    // Exercise visible stage input, not only startup. The per-game screenshots
    // are reviewed separately; generic clicks are not claimed as completion.
    for(const [x,y]of [[110,150],[450,150],[160,270],[480,270]]){
      await click(x,y);await page.waitForTimeout(220);
    }
    const b=await stage.boundingBox();
    const at=(x,y)=>[b.x+b.width*x/640,b.y+b.height*y/480];
    report.actions.push({type:'drag',from:[170,350],to:[320,240]});
    await page.mouse.move(...at(170,350));await page.mouse.down();
    await page.mouse.move(...at(320,240),{steps:12});await page.mouse.up();
    await page.keyboard.press('ArrowLeft');await page.keyboard.press('ArrowRight');
    await page.waitForTimeout(1800);
    await checkpoint('interaction');
    await click(220,460);await page.waitForTimeout(700);
    await click(220,460);await page.waitForTimeout(6000);
    await checkpoint('return');
    report.status=report.checkpoints.some(c=>c.snapshot.errors.length)?'script-error':'review';
  }catch(error){report.status='failed';report.error=String(error);}
  await fs.writeFile(path.join(output,`${movie}.json`),JSON.stringify(report,null,2));
  reports.push(report);
  console.log(JSON.stringify({movie,status:report.status,error:report.error,checkpoints:report.checkpoints.map(c=>({name:c.name,frame:c.snapshot.execution.current_frame,errors:c.snapshot.errors}))}));
  await page.close();
}
await fs.writeFile(path.join(output,'matrix.json'),JSON.stringify(reports,null,2));
await browser.close();
