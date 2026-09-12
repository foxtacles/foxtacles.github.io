import {chromium,openGame,click,move,save,check,out} from './play_helpers.mjs';
import {writeFile} from 'node:fs/promises';
const mode=Number(process.argv[2]||1),prefix=`DAG17-mode${mode}`;
check(mode===1||mode===2,'Mode must be1 or2');
const browser=await chromium.launch({headless:true}),page=await openGame(browser,'DAG17');
const history=[],keyChecks=[];let shots=0,maxPlayer=0,maxElk=0;
const read=()=>page.evaluate(()=>{
 const s=findus.snapshot(),g=s.globals.globals,result={frame:s.execution.current_frame,movie:s.execution.movie_name,errors:s.errors};
 for(const k of ['numberOfPlayers','clockTime','ballALive','animationCounter','startMouseH','stopX','changeInstopX','ballLoopCounter','FindusState','ElkGameOver','elkAlive','elkSpeed','ElkDirection','currentScorePlayer','currentScoreElk'])result[k]=Number(g[k]?.value);
 const sprites=JSON.parse(findus.vm.get_stage_snapshot()).sprites;result.elk=sprites.find(x=>x.channel===3);result.findus=sprites.find(x=>x.channel===17);return result;
});
const skipSpeech=async()=>{await click(page,320,300);await move(page,320,250);await page.waitForTimeout(400);};
try {
 await click(page,390,450);await page.waitForTimeout(700);await skipSpeech();
 await page.waitForTimeout(1200);
 if(mode===2){
  while((await read()).ballALive===1)await page.waitForTimeout(100);
  await click(page,615,397);await page.waitForTimeout(500);await skipSpeech();
  const before=await read();check(before.numberOfPlayers===2,'Two-player selector');
  await page.keyboard.down('ArrowRight');await page.waitForTimeout(1100);await page.keyboard.up('ArrowRight');
  const right=await read();await page.keyboard.down('ArrowLeft');await page.waitForTimeout(400);await page.keyboard.up('ArrowLeft');const left=await read();
  keyChecks.push({before,right,left});
  check(right.elk.x>before.elk.x&&left.elk.x<right.elk.x,'Secondplayer must steer elk both directions');
 }
 await save(page,`${prefix}-start`,{keyChecks});
 const start=Date.now();let lastReport=0,zeroSeen=false,finished=false,keyHeld=false;
 while(Date.now()-start<180000){
  const s=await read();check(s.errors.length===0,'Snowball VM errors');
  maxPlayer=Math.max(maxPlayer,s.currentScorePlayer||0);maxElk=Math.max(maxElk,s.currentScoreElk||0);
  if(s.ElkGameOver===1||s.clockTime===0)zeroSeen=true;
  if(zeroSeen&&s.clockTime>=119&&s.currentScorePlayer===0&&s.currentScoreElk===0){finished=true;break;}
  if(Date.now()-lastReport>10000){history.push({...s,elapsed:Date.now()-start,shots});console.log(JSON.stringify({mode,elapsed:Date.now()-start,time:s.clockTime,player:s.currentScorePlayer,elk:s.currentScoreElk,shots}));lastReport=Date.now();}
  if(s.clockTime>0&&s.ElkGameOver===0&&s.elk&&s.findus){
   if(mode===2){
    // First position the keyboard player's elk in the thrower's reach. After
    // the first hit, run to the far edge to exercise that player's scoring.
    const shouldRun=maxPlayer>0||s.elk.x<300;
    if(shouldRun&&!keyHeld){await page.keyboard.down('ArrowRight');keyHeld=true;}
    if(!shouldRun&&keyHeld){await page.keyboard.up('ArrowRight');keyHeld=false;}
   }
   if(s.ballALive===1){
    const remaining=Math.max(1,(10.8-s.animationCounter)/0.22);
    const motion=mode===2&&keyHeld?s.elkSpeed:(mode===1?s.ElkDirection*s.elkSpeed:0);
    const target=s.elk.x+motion*Math.min(remaining,12);
    const desired=(target-s.stopX)/50;
    const delta=Math.max(-150,Math.min(150,(desired-s.changeInstopX)/Math.max(3,remaining)/0.0007));
    await move(page,Math.max(1,Math.min(639,s.startMouseH+delta)),250);
   } else if(s.FindusState===1&&s.elkAlive===1){
    const target=Math.max(105,Math.min(495,s.elk.x+(mode===1?s.ElkDirection*40:0)));
    await move(page,target+(target>s.findus.x?5:-5),250);
    if(Math.abs(s.findus.x-target)<35&&s.elk.x>60&&s.elk.x<600){
     await page.mouse.down();await page.waitForTimeout(110);await page.mouse.up();shots++;
    }
   }
  }
  await page.waitForTimeout(50);
 }
 await page.keyboard.up('ArrowRight');await page.keyboard.up('ArrowLeft');
 const complete=await read();await save(page,`${prefix}-complete`,{history,keyChecks,shots,maxPlayer,maxElk,finished});
 check(finished,'Full timed round must finish feedback and reset');check(maxPlayer>0,'Mouseplayer must score');
 if(mode===2)check(maxElk>0,'Keyboardplayer must score');
 while((await read()).ballALive===1)await page.waitForTimeout(100);
 await click(page,mode===2?615:558,397);await page.waitForTimeout(500);await skipSpeech();
 const replay=await read();check(replay.numberOfPlayers===mode&&replay.clockTime>115&&replay.currentScorePlayer===0&&replay.currentScoreElk===0,'Mode-specific replay resets scores/time');
 await save(page,`${prefix}-replay`);
 await click(page,220,450);await move(page,320,250);await page.waitForTimeout(6500);
 const returned=await save(page,`${prefix}-return`);check(returned.execution.movie_name.toLowerCase().includes('kalender'),'Calendar return');
 check(returned.errors.length===0&&page.errors.length===0,'No VM/browser errors');
 await writeFile(new URL(`${prefix}-result.json`,out),JSON.stringify({passed:true,mode,shots,maxPlayer,maxElk,keyChecks,history,complete,replay},null,2));
 console.log(`${prefix} passed: ${shots} throws, score${maxPlayer}:${maxElk}, fullround,replay,calendar`);
}catch(error){await save(page,`${prefix}-failure`,{error:String(error),history,keyChecks,shots,maxPlayer,maxElk});throw error;}finally{await browser.close();}
