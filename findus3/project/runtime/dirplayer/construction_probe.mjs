import {chromium,openGame,click,move,snapshot,globalValue,waitMovie} from './play_helpers.mjs';
import {mkdir,writeFile,readFile} from 'node:fs/promises';
import {createHash} from 'node:crypto';
import path from 'node:path';
const interruptDialogue=process.env.FINDUS_INTERRUPT_DIALOG==='1';
const out=path.resolve('artifacts/runtime-tests/construction'+(interruptDialogue?'-interrupt':''));await mkdir(out,{recursive:true});
const engineSha256=createHash('sha256').update(await readFile('dist/web/engine/vm_rust_bg.wasm')).digest('hex');
const browser=await chromium.launch({headless:true});
const targets=process.argv.slice(2);
for(const movie of targets.length?targets:['KONSTR01','KONSTR02','KONSTR03']){
 const page=await openGame(browser,movie);const report={movie,engineSha256,interruptDialogue,startedAt:new Date().toISOString(),actions:[],checkpoints:[],checks:{}};
 async function snap(name){const s=await snapshot(page);report.checkpoints.push({name,snapshot:s,stack:await page.evaluate(()=>JSON.parse(findus.vm.mcp_get_call_stack(10,true))),active:await globalValue(page,'ObjektAktiv')});await page.locator('#stage_canvas_container').screenshot({path:path.join(out,`${movie}-${name}.png`)});return s;}
 async function spriteClick(n){const s=(await snapshot(page)).stage.sprites.find(s=>s.channel===n);if(!s)throw new Error(`sprite${n} missing`);await click(page,(s.rect[0]+s.rect[2])/2,(s.rect[1]+s.rect[3])/2);await move(page,620,30);}
 async function drag(n,x,y){
  const s=(await snapshot(page)).stage.sprites.find(s=>s.channel===n);if(!s)throw new Error(`sprite${n} missing`);
  const grab=await page.evaluate(s=>{const[l,t,r,b]=s.rect;for(let y=Math.max(0,t+2);y<Math.min(480,b);y+=3)for(let x=Math.max(0,l+2);x<Math.min(640,r);x+=3)if(findus.vm.player_get_mouse_sprite_at(x,y)===s.channel)return[x,y];return null;},s);
  if(!grab)throw new Error(`sprite${n} has no interactive grab point`);
  report.actions.push({drag:n,from:grab,to:[x,y]});await move(page,...grab);await page.waitForTimeout(160);await page.mouse.down();await page.waitForTimeout(180);report.actions.push({dragDown:n,state:await snapshot(page),stack:await page.evaluate(()=>JSON.parse(findus.vm.mcp_get_call_stack(8,true)))});
  for(let i=1;i<=15;i++){await move(page,grab[0]+(x-grab[0])*i/15,grab[1]+(y-grab[1])*i/15);await page.waitForTimeout(25);}
  await page.waitForTimeout(180);report.actions.push({dragMoved:n,state:await snapshot(page),stack:await page.evaluate(()=>JSON.parse(findus.vm.mcp_get_call_stack(8,true)))});await page.mouse.up();await page.waitForTimeout(250);await move(page,620,30);
 }
 try{
  await snap('intro');if(!await globalValue(page,'StartXPos')){await click(page,390,445);await move(page,620,30);}
  await page.waitForFunction(()=>{const g=JSON.parse(findus.vm.mcp_get_globals()).globals;const s=JSON.parse(findus.vm.get_stage_snapshot());return Boolean(g.StartXPos)&&s.frame>=32&&s.frame<=34;},null,{timeout:90000});await page.waitForTimeout(1500);
  await snap('board');
  const channels=await globalValue(page,'spriteNum'),xs=await globalValue(page,'StartXPos'),ys=await globalValue(page,'StartYPos');
  if(!channels)throw new Error('Assembly board has not initialized');
  const order=movie==='KONSTR01'?[4,3]:movie==='KONSTR02'?[2,3,4,8]:[2,3,5,4,6,7,8];
  for(const index of order){await drag(channels[index-1],xs[index-1],ys[index-1]);await snap(`part-${index}`);}
  await snap('assembled');await spriteClick(movie==='KONSTR01'?9:27);await page.waitForFunction(()=>JSON.parse(findus.vm.mcp_get_globals()).globals.OnOff?.value==='1',null,{timeout:10000});await page.waitForTimeout(1500);await snap('running');
  await page.waitForFunction(()=>JSON.parse(findus.vm.mcp_get_globals()).globals.OnOff?.value==='0',null,{timeout:60000});await snap('completed');
  report.checks.constructionCompleted=await globalValue(page,'KonstruktionFardig')===1;
  if(!interruptDialogue){await page.waitForFunction(()=>JSON.parse(findus.vm.mcp_get_context()).scope_count===0&&!JSON.parse(findus.vm.get_audio_state()).channels[0].busy,null,{timeout:45000});await snap('dialogue-finished');}
  await click(page,210,445);await move(page,620,30);
  if(interruptDialogue){
   // Director's authored button begins with `if the mouseDown`. A quick tap
   // buffered behind narration may therefore be ignored after release. It
   // must not reassert DOWN and deadlock its own queued mouseUp command.
   await page.waitForTimeout(20000);const released=await snap('after-interrupted-tap');
   report.checks.interruptedTapReleased=released.execution.mouse_down===false;
   const active=JSON.parse(await page.evaluate(()=>findus.vm.mcp_get_call_stack(10,true))).scopes;
   report.checks.noStuckReturnHandler=!active.some(s=>s.cast_lib===2&&s.cast_member===118&&s.handler_name==='mouseDown');
   if(!report.checks.interruptedTapReleased||!report.checks.noStuckReturnHandler)throw Error('Buffered return tap left the physical button or return handler stuck');
   if(!released.execution.movie_name.toLowerCase().startsWith('kalender')){
    report.checks.bufferedTapIgnoredByAuthoredGuard=true;
    await click(page,210,445);await move(page,620,30);
   }
  }
  await waitMovie(page,'kalender',20000);await snap('return');
  report.checks.returnedToCalendar=true;report.checks.noScriptErrors=report.checkpoints.every(c=>!c.snapshot.errors.length)&&!page.errors.length;
 }catch(error){report.error=String(error);try{await snap('failure');}catch{}}
 report.pageErrors=page.errors;await writeFile(path.join(out,`${movie}.json`),JSON.stringify(report,null,2));console.log(JSON.stringify({movie,checks:report.checks,error:report.error,states:report.checkpoints.map(c=>[c.name,c.snapshot.stage.frame,c.active])}));await page.close();
}
await browser.close();
