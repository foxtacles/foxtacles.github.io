// Reproducible low-level browser audit driver. Reads one JSON action per line.
import {chromium} from '../../tools/runtime-options/dirplayer-rs/node_modules/playwright/index.mjs';
import {mkdir,writeFile} from 'node:fs/promises';
import readline from 'node:readline';
const movie=process.argv[2] || 'DAG07';
const out=new URL(`../../artifacts/runtime-tests/interactions-4-7-9/${movie}-audit/`,import.meta.url);
await mkdir(out,{recursive:true});
const browser=await chromium.launch({headless:true});
const page=await browser.newPage({viewport:{width:1000,height:900}}),events=[],actions=[];
page.on('pageerror',e=>events.push(String(e)));
page.on('console',m=>{if(m.type()==='error')events.push(m.text());});
await page.goto(`http://127.0.0.1:8766/?movie=${movie}`);
await page.locator('#start').click({timeout:45000});
await page.waitForTimeout(5000);
const stage=await page.locator('#stage_canvas_container').boundingBox();
const move=async(x,y,steps=1)=>page.mouse.move(stage.x+x*stage.width/640,stage.y+y*stage.height/480,{steps});
const read=async code=>page.evaluate(async code=>JSON.parse(await window.findus.vm.mcp_eval_lingo(code)),code);
const snapshot=()=>page.evaluate(()=>({...window.findus.snapshot(),cursor:getComputedStyle(document.querySelector('canvas')).cursor}));
console.log(JSON.stringify({ready:true,movie,state:await snapshot()}));
for await(const line of readline.createInterface({input:process.stdin,crlfDelay:Infinity})) {
 try {
  const action=JSON.parse(line);let result;
  if(action.quit)break;
  if(action.move){await move(...action.move);await page.waitForTimeout(action.wait??250);}
  if(action.click){const [x,y]=action.click;await page.mouse.click(stage.x+x*stage.width/640,stage.y+y*stage.height/480,{delay:action.hold??150});await page.waitForTimeout(action.wait??500);}
  if(action.drag){const [x,y,toX,toY]=action.drag;await move(x,y);await page.waitForTimeout(200);await page.mouse.down();await page.waitForTimeout(200);await move(toX,toY,20);await page.waitForTimeout(action.hold??300);await page.mouse.up();await page.waitForTimeout(action.wait??700);}
  if(action.read)result=await read(action.read);
  if(action.eval)result=await page.evaluate(action.eval);
  if(action.wait&&!action.click&&!action.drag&&!action.move)await page.waitForTimeout(action.wait);
  const state=await snapshot();
  if(action.shot)await page.screenshot({path:new URL(`${action.shot}.png`,out).pathname});
  actions.push({action,result,state});
  await writeFile(new URL('audit.json',out),JSON.stringify({movie,actions,events},null,2));
  console.log(JSON.stringify({result,state}));
 }catch(error){console.log(JSON.stringify({error:String(error)}));}
}
await browser.close();
