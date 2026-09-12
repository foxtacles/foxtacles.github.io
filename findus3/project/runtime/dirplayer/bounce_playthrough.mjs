import {chromium,openGame,click,move,save,check} from './play_helpers.mjs';
const browser=await chromium.launch({headless:true}),page=await openGame(browser,'DAG15');
const history=[];
const read=()=>page.evaluate(()=>{
 const s=findus.snapshot(),g=s.globals.globals;
 return {frame:s.execution.current_frame,movie:s.execution.movie_name,u:Number(g.u?.value),velocity:Number(g.s?.value),score:Number(g.rakna?.value),lives:Number(g.liv?.value),plock:Number(g.plock?.value),sprites:JSON.parse(findus.vm.get_stage_snapshot()).sprites,errors:s.errors};
});
try {
 await click(page,390,450);await move(page,345,380);await page.waitForTimeout(500);
 await save(page,'DAG15-start');
 const started=Date.now();let lastReport=0,lastScore=-1,minLives=3;
 while(Date.now()-started<240000){
  const s=await read();check(s.errors.length===0,'Bounce VM errors');minLives=Math.min(minLives,s.lives);
  if(s.frame>=27&&s.frame<35)break;
  check(s.frame!==16,'Bounce game ran out of lives');
  const ball=s.sprites.find(x=>x.channel===3),targets=s.sprites.filter(x=>x.channel>=8&&x.channel<=20&&x.visible);
  if(ball&&targets.length){
   const cx=ball.x+24; // Director integer width / 2 in the authored bounce formula.
   const target=targets.sort((a,b)=>Math.abs((a.rect[0]+a.rect[2])/2-cx)-Math.abs((b.rect[0]+b.rect[2])/2-cx))[0];
   const targetX=(target.rect[0]+target.rect[2])/2,targetY=(target.rect[1]+target.rect[3])/2-29;
   const flight=(7-Math.sqrt(Math.max(0,49-0.2*(288-targetY))))/0.1;
   const desired=(targetX-cx)/Math.max(20,flight);
   const vx=(desired<0?-1:1)*Math.max(1,Math.min(7,Math.round(Math.abs(desired))));
   const paddle=Math.max(15,Math.min(625,cx-vx*5));
   await move(page,paddle,380);
  }
  if(s.score!==lastScore||Date.now()-lastReport>10000){
   const report={elapsed:Date.now()-started,score:s.score,lives:s.lives,u:s.u,velocity:s.velocity,ball:ball&&[ball.x,ball.y],targets:targets.map(t=>t.channel)};
   history.push(report);console.log(JSON.stringify(report));lastScore=s.score;lastReport=Date.now();
  }
  await page.waitForTimeout(20);
 }
 const complete=await read();await save(page,'DAG15-complete',{history,minLives});
 check(complete.score>=12&&complete.frame>=27&&complete.frame<35,'Collect12items and reach success');
 await click(page,390,450);await move(page,345,380);await page.waitForTimeout(500);
 const restarted=await read();check(restarted.frame===5&&restarted.score===0&&restarted.lives===3,'Restart must reset score/lives');
 await save(page,'DAG15-restart');
 await click(page,220,450);await move(page,320,400);await page.waitForTimeout(6500);
 const returned=await save(page,'DAG15-return');
 check(returned.execution.movie_name.toLowerCase().includes('kalender'),'Return to calendar');
 check(returned.errors.length===0&&page.errors.length===0,'No VM/browser errors');
 console.log('DAG15 passed:12items,success,restart,calendar via actual pointer steering');
}catch(error){await save(page,'DAG15-failure',{error:String(error),history});throw error;}finally{await browser.close();}
