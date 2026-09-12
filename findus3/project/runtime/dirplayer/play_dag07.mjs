import {chromium} from '../../tools/runtime-options/dirplayer-rs/node_modules/playwright/index.mjs';
import {mkdir,writeFile} from 'node:fs/promises';
import assert from 'node:assert/strict';
const out=new URL('../../artifacts/runtime-tests/interactions-4-7-9/DAG07-completion/',import.meta.url);
await mkdir(out,{recursive:true});
const browser=await chromium.launch({headless:true});
const page=await browser.newPage({viewport:{width:1000,height:900}}),actions=[];
const targets=[[233,147],[302,146],[374,154],[234,224],[302,223],[373,227],[234,304],[302,305],[375,296]];
try{
 await page.goto('http://127.0.0.1:8766/?movie=DAG07');
 await page.locator('#start').click({timeout:45000});await page.waitForTimeout(6000);
 const box=await page.locator('#stage_canvas_container').boundingBox();
 const move=async(x,y,steps=1)=>page.mouse.move(box.x+x*box.width/640,box.y+y*box.height/480,{steps});
 await page.mouse.click(box.x+390*box.width/640,box.y+445*box.height/480,{delay:150});
 await page.waitForTimeout(5500);
 const read=async code=>page.evaluate(async code=>JSON.parse(await window.findus.vm.mcp_eval_lingo(code)).result_value,code);
 const initial=await page.evaluate(()=>window.findus.snapshot());
 assert.equal(initial.execution.current_frame,5);assert.equal(initial.errors.length,0);
 const linCast=Number(initial.globals.globals.LinCast.value);
 for(let n=21;n>=13;n--){
  const member=Number(await read(`sprite(${n}).memberNum`));
  const index=member-linCast;
  assert(index>=0&&index<9,`sprite${n} member${member} inconsistent with LinCast${linCast}`);
  const loc=(await read(`sprite(${n}).loc`)).match(/-?\d+/g).map(Number);
  const rect=(await read(`sprite(${n}).rect`)).match(/-?\d+/g).map(Number);
  const pick=await page.evaluate(({n,rect,loc})=>{let point=null,d=Infinity;for(let y=rect[1];y<rect[3];y+=2)for(let x=rect[0];x<rect[2];x+=2){if(window.findus.vm.player_get_sprite_at(x,y)!==n)continue;const dist=(x-loc[0])**2+(y-loc[1])**2;if(dist<d){point=[x,y];d=dist;}}return point;},{n,rect,loc});
  assert(pick,`No opaque grab point for sprite${n}`);
  const target=[targets[index][0]+pick[0]-loc[0],targets[index][1]+pick[1]-loc[1]];
  await move(...pick);await page.waitForTimeout(200);await page.mouse.down();await page.waitForTimeout(200);await move(...target,20);await page.waitForTimeout(300);await page.mouse.up();await page.waitForTimeout(700);
  const state=await page.evaluate(()=>window.findus.snapshot());
  actions.push({sprite:n,member,pick,target,state});
  assert.equal(state.globals.globals.klar.value,String(22-n));assert.equal(state.errors.length,0);
 }
 await page.waitForTimeout(1400);const final=await page.evaluate(()=>window.findus.snapshot());
 assert.equal(final.globals.globals.klar.value,'9');
 assert.equal(final.execution.current_frame,15);
 assert.equal(final.errors.length,0);
 await page.screenshot({path:new URL('completed.png',out).pathname});
 await writeFile(new URL('result.json',out),JSON.stringify({passed:true,method:'Read-only sprite geometry/member inspection followed by nine actual pointer drags; no game-state writes',actions,final},null,2));
 console.log('DAG07 passed: all9 randomized pieces placed, completion reached, no errors');
}catch(error){await page.screenshot({path:new URL('failure.png',out).pathname});await writeFile(new URL('result.json',out),JSON.stringify({passed:false,error:String(error),actions,state:await page.evaluate(()=>window.findus.snapshot()),audio:await page.evaluate(()=>JSON.parse(window.findus.vm.get_audio_state()))},null,2));throw error;}
finally{await browser.close();}
