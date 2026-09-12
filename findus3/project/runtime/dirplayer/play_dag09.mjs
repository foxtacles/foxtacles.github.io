import {chromium} from '../../tools/runtime-options/dirplayer-rs/node_modules/playwright/index.mjs';
import {mkdir,writeFile} from 'node:fs/promises';
import assert from 'node:assert/strict';
const out=new URL('../../artifacts/runtime-tests/interactions-4-7-9/DAG09-completion/',import.meta.url);
await mkdir(out,{recursive:true});
const browser=await chromium.launch({headless:true});
const page=await browser.newPage({viewport:{width:1000,height:900}}),actions=[];
try{
 await page.goto('http://127.0.0.1:8766/?movie=DAG09');
 await page.locator('#start').click({timeout:45000});await page.waitForTimeout(6000);
 const box=await page.locator('#stage_canvas_container').boundingBox();
 const move=async(x,y,steps=1)=>page.mouse.move(box.x+x*box.width/640,box.y+y*box.height/480,{steps});
 await page.mouse.click(box.x+390*box.width/640,box.y+445*box.height/480,{delay:150});await page.waitForTimeout(1000);
 const drag=async(from,to)=>{await move(...from);await page.waitForTimeout(200);await page.mouse.down();await page.waitForTimeout(200);await move(...to,20);await page.waitForTimeout(300);await page.mouse.up();await page.waitForTimeout(600);};
 // First reject an incorrect placement, then place all seven branches.
 await drag([547,375],[100,100]);
 let state=await page.evaluate(()=>window.findus.snapshot());
 assert.equal(state.globals.globals.klar.value,'0');
 const reset=await page.evaluate(async()=>JSON.parse(await window.findus.vm.mcp_eval_lingo('sprite(20).loc')).result_value);
 assert.equal(reset,'point(493, 361)');actions.push({invalid_drop_rejected:true,state});
 const gestures=[[547,375,372,297],[478,394,297,262],[494,343,253,188],[578,379,359,228],[466,354,355,180],[574,333,339,146],[509,396,321,174]];
 for(let i=0;i<gestures.length;i++){
  const [x,y,toX,toY]=gestures[i];await drag([x,y],[toX,toY]);
  state=await page.evaluate(()=>window.findus.snapshot());
  actions.push({drag:gestures[i],state});
  assert.equal(state.globals.globals.klar.value,String(i+1));
  assert.equal(state.errors.length,0);
 }
 await page.waitForTimeout(1000);state=await page.evaluate(()=>window.findus.snapshot());
 assert.equal(state.execution.current_frame,15);
 await page.screenshot({path:new URL('completed.png',out).pathname});
 await writeFile(new URL('result.json',out),JSON.stringify({passed:true,method:'Actual pointer input; one rejected drop, seven accepted drops, completion frame15',actions,final:state},null,2));
 console.log('DAG09 passed: invalid placement rejected; all 7 branches placed; completion frame15; no script errors');
}catch(error){await page.screenshot({path:new URL('failure.png',out).pathname});await writeFile(new URL('result.json',out),JSON.stringify({passed:false,error:String(error),actions,state:await page.evaluate(()=>window.findus.snapshot())},null,2));throw error;}
finally{await browser.close();}
