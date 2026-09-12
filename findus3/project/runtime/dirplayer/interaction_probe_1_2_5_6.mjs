import {chromium} from '../../tools/runtime-options/dirplayer-rs/node_modules/playwright/index.mjs';
import {mkdir,writeFile} from 'node:fs/promises';
import path from 'node:path';
import {globalValue} from './play_helpers.mjs';
const steep=process.env.FINDUS_STEEP==='1';const slopeX=steep?510:350;
const out=path.resolve('artifacts/runtime-tests/interactions-1-2-5-6'+(steep?'-steep':''));
await mkdir(out,{recursive:true});
const browser=await chromium.launch({headless:true});
const targets=process.argv.slice(2);const matrix=[];
for(const movie of targets.length?targets:['DAG01','DAG02','DAG05','DAG06']){
 const page=await browser.newPage({viewport:{width:1000,height:900}});
 const report={movie,slope:steep?'steep':'small',actions:[],checkpoints:[],events:[],checks:{}};
 page.on('pageerror',e=>report.events.push(String(e)));
 page.setDefaultTimeout(45000);
 const stage=page.locator('#stage_canvas_container');
 async function snapshot(){return page.evaluate(()=>{
   const snapshot=window.findus.snapshot();
   const globals=snapshot.globals.globals;
   const props={};
   for(const [key,datum] of Object.entries(globals))if(datum.type_name==='instance'||datum.type_name==='script_instance_ref'||datum.type_name==='script_instance'){
     try{props[key]=JSON.parse(window.findus.vm.mcp_inspect_datum(datum.datum_id));}catch{}
   }
   return {...snapshot,callStack:JSON.parse(window.findus.vm.mcp_get_call_stack(10,true)),stage:JSON.parse(window.findus.vm.get_stage_snapshot()),props,audio:JSON.parse(window.findus.vm.get_audio_state())};
 });}
 async function checkpoint(name){const state=await snapshot();report.checkpoints.push({name,state});await stage.screenshot({path:path.join(out,`${movie}-${name}.png`)});return state;}
 async function point(x,y){const b=await stage.boundingBox();return[b.x+x*b.width/640,b.y+y*b.height/480];}
 async function click(x,y){report.actions.push({click:[x,y]});await page.mouse.move(...await point(x,y));await page.waitForTimeout(120);await page.mouse.down();await page.waitForTimeout(100);if(movie==='DAG06'&&y===359)report.slopeDown=await snapshot();await page.mouse.up();await page.waitForTimeout(160);await page.mouse.move(...await point(620,30));}
 async function spriteClick(channel){const s=(await snapshot()).stage.sprites.find(s=>s.channel===channel);if(!s)throw new Error(`sprite${channel} absent`);await click((s.rect[0]+s.rect[2])/2,(s.rect[1]+s.rect[3])/2);}
 async function hold(key,ms){report.actions.push({hold:key,ms});await page.keyboard.down(key);await page.waitForTimeout(ms);await page.keyboard.up(key);}
 try{
  await page.goto(`http://127.0.0.1:8766/?movie=${movie}`);await page.locator('#start').click();await page.waitForTimeout(1500);
  await checkpoint('intro');await click(390,445);await page.waitForTimeout(2200);
  const before=await checkpoint('play');
  if(movie==='DAG01'){
   await page.waitForFunction(()=>JSON.parse(window.findus.vm.get_stage_snapshot()).frame===15,null,{timeout:20000});await checkpoint('race-start');
   await page.keyboard.down('Shift');await page.waitForTimeout(500);await page.keyboard.down('ArrowRight');await page.waitForTimeout(850);await checkpoint('gas-steer-held');await page.keyboard.up('ArrowRight');await page.keyboard.up('Shift');await page.waitForTimeout(350);
   await checkpoint('moved');await spriteClick(41);await page.waitForTimeout(1500);await checkpoint('restart');await page.waitForFunction(()=>JSON.parse(window.findus.vm.get_stage_snapshot()).frame===15,null,{timeout:20000});await spriteClick(40);await page.waitForFunction(()=>JSON.parse(window.findus.vm.get_stage_snapshot()).movie.toLowerCase().includes('kalender'),null,{timeout:15000});await checkpoint('return');
  }else if(movie==='DAG02'){
   await page.locator('#controls').click();const button=page.locator('[data-key="ArrowUp"]');await button.hover();await page.mouse.down();await page.waitForTimeout(700);await page.mouse.up();await checkpoint('touch-reel');
   await stage.focus();for(let i=0;i<3;i++){await page.keyboard.press('ArrowDown');await page.waitForTimeout(65);}await page.keyboard.press('ArrowLeft');await checkpoint('rod-moved');
   await spriteClick(24);await page.waitForFunction(()=>{const g=JSON.parse(window.findus.vm.mcp_get_globals()).globals;const k=Object.keys(g).find(k=>/^sp.Pos$/.test(k));return g[k]?.value==='6';},null,{timeout:15000});await checkpoint('restart');await spriteClick(23);await page.waitForFunction(()=>JSON.parse(window.findus.vm.get_stage_snapshot()).movie.toLowerCase().includes('kalender'),null,{timeout:15000});await checkpoint('return');
  }else if(movie==='DAG05'){
   await click(280,200);await page.waitForTimeout(250);
   report.nailProgress=[];
   for(const channel of [28,48,68,88]){
    for(let attempt=0;attempt<16;attempt++){
     const nails=await globalValue(page,'lSpikObjMatris');const nail=nails.find(n=>n.Kanal===channel);
     report.nailProgress.push({channel,attempt,nails});if(nail.AntalSpikarNedslagna>0)break;
     if(nail.status===1){await page.waitForTimeout(150);continue;}
     const s=(await snapshot()).stage.sprites.find(s=>s.channel===channel);await click(s.x,s.y);await page.waitForTimeout(60);
    }
   }
   report.completedNails=await globalValue(page,'lSpikObjMatris');
   await checkpoint('nails-hit');
   await page.waitForFunction(()=>JSON.parse(findus.vm.mcp_get_globals()).globals.SpeletSlut?.value==='1',null,{timeout:90000});await checkpoint('natural-finish');
   await page.waitForFunction(()=>JSON.parse(findus.vm.mcp_get_globals()).globals.Poang?.value==='0',null,{timeout:90000});await checkpoint('round-reset');
   await click(390,445);await page.waitForTimeout(1500);await checkpoint('restart');await click(210,445);await page.waitForFunction(()=>JSON.parse(window.findus.vm.get_stage_snapshot()).movie.toLowerCase().includes('kalender'),null,{timeout:15000});await checkpoint('return');
  }else if(movie==='DAG06'){
   // Choose the authored small-slope control after the menu click completes.
   await page.waitForFunction(()=>JSON.parse(window.findus.vm.get_stage_snapshot()).frame===11,null,{timeout:20000});
   await page.mouse.move(...await point(slopeX,359));await page.waitForTimeout(350);await checkpoint('slope-hover');report.slopeHits=await page.evaluate(()=>{const r=[];for(let y=346;y<376;y+=4)for(let x=280;x<587;x+=10)r.push({x,y,sprite:findus.vm.player_get_sprite_at(x,y),target:findus.vm.player_get_mouse_sprite_at(x,y)});return r;});
   report.slopeScripts=await page.evaluate(async()=>{const r={};for(const n of[17,18,25,28]){const value=JSON.parse(await findus.vm.mcp_eval_lingo(`sprite(${n}).scriptInstanceList`));r[n]={...value,instances:[...value.result_value.matchAll(/DatumRef\((\d+)\)/g)].map(m=>JSON.parse(findus.vm.mcp_inspect_datum(Number(m[1]))))};}return r;});
   await click(slopeX,359);await page.waitForTimeout(1800);await checkpoint('slope-start');
   await hold('ArrowRight',850);await checkpoint('steered-right');await hold('ArrowLeft',450);await hold('ArrowDown',250);await page.waitForTimeout(600);await checkpoint('steered-jump');
   await spriteClick(31);await page.waitForTimeout(1200);await checkpoint('restart-menu');await spriteClick(31);await page.waitForFunction(()=>JSON.parse(findus.vm.get_stage_snapshot()).frame===11,null,{timeout:10000});await page.waitForTimeout(1400);await click(slopeX,359);await page.waitForFunction(()=>JSON.parse(findus.vm.get_stage_snapshot()).frame===12,null,{timeout:10000});await checkpoint('restart');
   await page.waitForFunction(()=>Number(JSON.parse(findus.vm.mcp_get_globals()).globals.langd?.value)>800,null,{timeout:100000});await checkpoint('course-complete');await page.waitForFunction(()=>JSON.parse(findus.vm.get_stage_snapshot()).frame===10,null,{timeout:20000});await spriteClick(30);await page.waitForFunction(()=>JSON.parse(window.findus.vm.get_stage_snapshot()).movie.toLowerCase().includes('kalender'),null,{timeout:15000});await checkpoint('return');
  }
  const named=name=>report.checkpoints.find(c=>c.name===name)?.state;
  const global=(state,key)=>Number(state.globals.globals[key]?.value);
  const sprite=(state,key)=>state.stage.sprites.find(s=>s.channel===key);
  if(movie==='DAG01'){
    const initial=sprite(named('race-start'),10),moved=sprite(named('gas-steer-held'),10);
    report.checks.gasMovesFindus=initial.x!==moved.x||initial.y!==moved.y;
    report.checks.steeringChangesFacing=initial.member!==moved.member;
    const restarted=sprite(named('restart'),10);report.checks.restartResetsRacePosition=restarted.x===initial.x&&restarted.y===initial.y;
  }else if(movie==='DAG02'){
    const key=Object.keys(named('play').globals.globals).find(k=>/^l.ngd$/.test(k));
    const rodKey=Object.keys(named('play').globals.globals).find(k=>/^sp.Pos$/.test(k));
    report.checks.virtualArrowRepeatReelsIn=global(named('touch-reel'),key)<global(named('play'),key);
    report.checks.downArrowPaysOut=global(named('rod-moved'),key)>global(named('touch-reel'),key);
    report.checks.arrowChangesRodAngle=global(named('rod-moved'),rodKey)!==global(named('play'),rodKey);
    report.checks.restartResetsRod=global(named('restart'),rodKey)===6;
  }else if(movie==='DAG05'){
    report.checks.hammerScores=global(named('nails-hit'),'Poang')>0;
    report.checks.allFourNailsScored=report.completedNails?.every(n=>n.AntalSpikarNedslagna>0);
    report.checks.completedNailScore=global(named('nails-hit'),'Poang');
    report.checks.naturalEndAndNarrationReturn=global(named('natural-finish'),'SpeletSlut')===1&&global(named('round-reset'),'Poang')===0;
    report.checks.restartResetsScore=global(named('restart'),'Poang')===0;
  }else if(movie==='DAG06'){
    const initial=sprite(named('slope-start'),13),moved=sprite(named('steered-right'),13);
    report.checks.steeringMovesRider=[moved,sprite(named('steered-jump'),13)].some(s=>s.x!==initial.x);
    report.checks.courseAdvances=global(named('steered-jump'),'langd')>global(named('slope-start'),'langd');
    report.checks.fullCourseCompleted=global(named('course-complete'),'langd')>800;
    report.checks.restartResetsDistance=global(named('restart'),'langd')<global(named('steered-jump'),'langd');
  }
  report.checks.noScriptErrors=report.checkpoints.every(c=>!c.state.errors.length);
  report.checks.returnedToCalendar=report.checkpoints.at(-1).state.stage.movie.toLowerCase().includes('kalender');
 }catch(error){report.error=String(error);try{await checkpoint('failure');}catch{}}
 await writeFile(path.join(out,`${movie}.json`),JSON.stringify(report,null,2));matrix.push(report);
 console.log(JSON.stringify({movie,checks:report.checks,error:report.error,states:report.checkpoints.map(c=>({name:c.name,movie:c.state.stage.movie,frame:c.state.stage.frame,errors:c.state.errors}))}));
 await page.close();
}
await writeFile(path.join(out,'matrix.json'),JSON.stringify(matrix.map(({checkpoints,...r})=>({...r,states:checkpoints.map(c=>({name:c.name,movie:c.state.stage.movie,frame:c.state.stage.frame,errors:c.state.errors}))})),null,2));
await browser.close();
