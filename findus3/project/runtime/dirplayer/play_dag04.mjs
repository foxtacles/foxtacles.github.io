import {chromium} from '../../tools/runtime-options/dirplayer-rs/node_modules/playwright/index.mjs';
import {mkdir,writeFile} from 'node:fs/promises';
import assert from 'node:assert/strict';
const out=new URL('../../artifacts/runtime-tests/interactions-4-7-9/DAG04-completion/',import.meta.url);
await mkdir(out,{recursive:true});
const browser=await chromium.launch({headless:true});
const page=await browser.newPage({viewport:{width:1000,height:900}}),actions=[],errors=[];
page.on('pageerror',e=>errors.push(String(e)));
await page.goto('http://127.0.0.1:8766/?movie=DAG04');
await page.locator('#start').click({timeout:45000});
await page.waitForTimeout(6000);
const box=await page.locator('#stage_canvas_container').boundingBox();
const point=(x,y)=>[box.x+x*box.width/640,box.y+y*box.height/480];
const click=async(x,y)=>{await page.mouse.click(...point(x,y),{delay:150});};
const read=async code=>page.evaluate(async c=>JSON.parse(await window.findus.vm.mcp_eval_lingo(c)).result_value,code);
await click(390,445);await page.waitForTimeout(800);
await page.screenshot({path:new URL('difficulty.png',out).pathname});
await click(320,269);await page.waitForTimeout(700);
const start=Date.now();
let lastThrow=0;
while(Date.now()-start<45000){
 const state=await page.evaluate(()=>window.findus.snapshot());
 const globals=state.globals.globals;
 const hits=Number(globals.klubba?.value),misses=Number(globals.tupp?.value);
 if(hits>=49||misses>=42){actions.push({end:true,hits,misses,state});break;}
 if(state.errors.length){errors.push(...state.errors);break;}
 if(state.execution.current_frame===5 && Date.now()-lastThrow>900 && await read('sprite(10).visible')==='1'){
  const rect=(await read('sprite(10).rect')).match(/-?\d+/g).map(Number);
  const x=Math.round((rect[0]+rect[2])/2),y=Math.round((rect[1]+rect[3])/2);
  await page.mouse.move(...point(x,y));await page.waitForTimeout(90);
  await click(x,y);lastThrow=Date.now();
  actions.push({throw:[x,y],hitsBefore:hits,missesBefore:misses,rect});
 }
 await page.waitForTimeout(100);
}
await page.waitForTimeout(1600);
const final=await page.evaluate(()=>window.findus.snapshot());
const passed=final.execution.current_frame===10 && final.globals.globals.klubba?.value==='49' && final.globals.globals.tupp?.value==='35' && final.errors.length===0 && errors.length===0;
await page.screenshot({path:new URL('result.png',out).pathname});
await writeFile(new URL('result.json',out),JSON.stringify({passed,method:'Actual pointer moves/presses only; read-only debugger locates animated chicken hit boxes',actions,final,errors},null,2));
console.log(JSON.stringify({context:final.context,globals:final.globals,errors}));
await browser.close();
assert(passed,'DAG04 must reach victory after seven successful throws and zero misses');
