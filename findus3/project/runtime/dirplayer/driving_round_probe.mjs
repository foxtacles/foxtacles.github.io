import {chromium,openGame,click,move,snapshot,globalValue,waitMovie} from './play_helpers.mjs';
import {mkdir,writeFile} from 'node:fs/promises';
import path from 'node:path';
const out=path.resolve('artifacts/runtime-tests/driving-round');await mkdir(out,{recursive:true});
const browser=await chromium.launch({headless:true});const page=await openGame(browser,'DAG01');const report={checks:{},checkpoints:[],control:[]};
async function state(){return page.evaluate(()=>{const g=JSON.parse(findus.vm.mcp_get_globals()).globals;const f=g.gFindus?JSON.parse(findus.vm.mcp_inspect_datum(g.gFindus.datum_id)).properties:{};const n=v=>v?Number(v.value):null;return{frame:JSON.parse(findus.vm.get_stage_snapshot()).frame,time:n(g.gGameTime),lap:n(g.gVarvCount),cp:n(g.gNextCP),hona:n(g.hona),x:n(f.xPos),y:n(f.yPos),angle:n(f.angle),target:n(f.targetangle),speed:n(f.fp_speed),turn:n(f.turnangle)};});}
async function save(name){const s={name,state:await state(),snapshot:await snapshot(page),stack:await page.evaluate(()=>JSON.parse(findus.vm.mcp_get_call_stack(10,true)))};report.checkpoints.push(s);await page.locator('#stage_canvas_container').screenshot({path:path.join(out,name+'.png')});return s;}
const keys=new Set();async function key(key,down){if(down&&!keys.has(key)){await page.keyboard.down(key);keys.add(key);}else if(!down&&keys.has(key)){await page.keyboard.up(key);keys.delete(key);}}
try{
 await page.waitForFunction(()=>JSON.parse(findus.vm.mcp_get_globals()).globals.hona?.value==='1',null,{timeout:45000});await save('narration-finished');
 await click(page,390,445);await move(page,620,30);await page.waitForFunction(()=>Number(JSON.parse(findus.vm.mcp_get_globals()).globals.gGameTime?.value)>=0,null,{timeout:30000});await save('race-start');
 report.checkpointsRects=await globalValue(page,'gCPRects');
 // White floor corridor from the original collision bitmap. Feedback uses only
 // read-only game state; steering and gas are physical browser key events.
 const route=[[450,70],[435,135],[330,155],[210,160],[145,110],[80,105],[60,230],[130,275],[150,355],[205,380],[245,420],[320,405],[375,350],[455,375],[530,405],[590,380],[590,270],[505,250],[485,180]];
 const deadline=Date.now()+240000;
 outer:for(let lap=0;lap<4;lap++)for(const [x,y]of route){
  if(Date.now()>deadline)throw new Error('Driving controller exceeded four-minute budget');
  let end=Date.now()+8000;while(Date.now()<end){const s=await state();report.control.push({...s,goal:[x,y]});if(s.frame!==15)break;const dist=Math.hypot(x-s.x,y-s.y);if(dist<24)break;const angle=(Math.atan2(s.y-y,x-s.x)*180/Math.PI+360)%360;const delta=((angle-s.target+540)%360)-180;
   const gas=Math.abs(delta)<12&&dist>38;const steering=delta>5?'ArrowLeft':delta< -5?'ArrowRight':null;
   for(const held of [...keys])if(held!==(gas?'Shift':null)&&held!==steering)await key(held,false);
   await key('Shift',gas);if(steering){await page.keyboard.down(steering);keys.add(steering);}await page.waitForTimeout(100);
  }
  await key('Shift',false);await key('ArrowLeft',false);await key('ArrowRight',false);await page.waitForTimeout(300);if((await state()).frame!==15)break outer;
 }
 await save('race-finished');report.checks.threeLapFinish=(await state()).frame===16;
}catch(error){report.error=String(error);await save('failure');}
for(const k of keys)await page.keyboard.up(k);report.pageErrors=page.errors;report.checks.noScriptErrors=report.checkpoints.every(c=>!c.snapshot.errors.length)&&!page.errors.length;await writeFile(path.join(out,'report.json'),JSON.stringify(report,null,2));console.log(JSON.stringify({checks:report.checks,error:report.error,states:report.checkpoints.map(s=>[s.name,s.state])}));await browser.close();
