import {chromium,openGame,click,move,snapshot,globalValue,waitMovie} from './play_helpers.mjs';
import {mkdir,writeFile} from 'node:fs/promises';import path from 'node:path';
const out=path.resolve('artifacts/runtime-tests/fishing-round');await mkdir(out,{recursive:true});
const browser=await chromium.launch({headless:true});const page=await openGame(browser,'DAG02');const report={checkpoints:[],controls:[],checks:{}};
async function state(){return page.evaluate(()=>{const g=JSON.parse(findus.vm.mcp_get_globals()).globals;const n=k=>Number(g[k]?.value);const st=JSON.parse(findus.vm.get_stage_snapshot());return{frame:st.frame,rod:n(Object.keys(g).find(k=>/^sp.Pos$/.test(k))),length:n(Object.keys(g).find(k=>/^l.ngd$/.test(k))),swing:n('maxvinkel'),anchor:[n('horPosLina'),n('vertPosLina')],result:g.resultat?.value,pan:st.sprites.find(s=>s.channel===8),fish:st.sprites.find(s=>s.channel===11)};});}
async function save(name){const s={name,state:await state(),snapshot:await snapshot(page),stack:await page.evaluate(()=>JSON.parse(findus.vm.mcp_get_call_stack(10,true)))};report.checkpoints.push(s);await page.locator('#stage_canvas_container').screenshot({path:path.join(out,name+'.png')});return s;}
async function press(key){await page.keyboard.down(key);await page.waitForTimeout(45);await page.keyboard.up(key);await page.waitForTimeout(45);report.controls.push({key,state:await state()});}
try{
 await click(page,390,445);await move(page,620,30);await page.waitForFunction(()=>JSON.parse(findus.vm.get_stage_snapshot()).frame===8,null,{timeout:20000});await save('start');
 for(let j=0;j<5;j++)await press('ArrowRight');
 const poses=[];for(let j=1;j<=11;j++){poses.push(await state());if(j<11)await press('ArrowLeft');}
 const target=(poses[0].pan.rect[0]+poses[0].pan.rect[2])/2;
 const best=poses.reduce((best,s)=>Math.abs(s.anchor[0]+3-target)<Math.abs(best.anchor[0]+3-target)?s:best,poses[0]);report.poses=poses;report.target={panCenter:target,pose:best.rod};
 for(let j=11;j>best.rod;j--)await press('ArrowRight');
 for(let j=0;j<110&&(await state()).swing>1;j++)await press('ArrowUp');
 await save('aligned');
 await page.waitForFunction(()=>JSON.parse(findus.vm.mcp_get_globals()).globals.resultat?.value?.includes('Fina fisken!'),null,{timeout:65000});await save('caught');report.checks.fishCaught=true;
 await page.waitForTimeout(2500);await save('feedback');
 await click(page,390,445);await move(page,620,30);await page.waitForFunction(()=>{const g=JSON.parse(findus.vm.mcp_get_globals()).globals;const k=Object.keys(g).find(k=>/^sp.Pos$/.test(k));return g[k]?.value==='6'&&JSON.parse(findus.vm.get_stage_snapshot()).frame===8;},null,{timeout:20000});await save('restart');report.checks.restartWorks=true;
 await click(page,210,445);await move(page,620,30);await waitMovie(page,'kalender',20000);await save('return');report.checks.returnedToCalendar=true;report.checks.noScriptErrors=report.checkpoints.every(c=>!c.snapshot.errors.length)&&!page.errors.length;
}catch(error){report.error=String(error);await save('failure');}
report.pageErrors=page.errors;await writeFile(path.join(out,'report.json'),JSON.stringify(report,null,2));console.log(JSON.stringify({checks:report.checks,error:report.error,target:report.target,states:report.checkpoints.map(c=>[c.name,c.state])}));await browser.close();
