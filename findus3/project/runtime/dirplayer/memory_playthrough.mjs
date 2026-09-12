import {chromium,openGame,startPlay,click,move,snapshot,globalValue,save,check,grabPoint} from './play_helpers.mjs';
const browser=await chromium.launch();
const page=await openGame(browser,'DAG03');
try {
  await startPlay(page);
  await move(page,320,200);
  const before=await save(page,'DAG03-start');
  check(before.context.current_frame===6,'Memory game did not start');
  const values=await globalValue(page,'slumplistan');
  check(values.length===24,'Expected24 memory positions');
  const pairs=new Map();
  values.forEach((sound,i)=>{if(!pairs.has(sound))pairs.set(sound,[]);pairs.get(sound).push(i+10);});
  check(pairs.size===12,'Expected12 sound pairs');
  const positions=new Map();
  for(const s of before.stage.sprites.filter(s=>s.channel>=10&&s.channel<=33)){
    const p=await grabPoint(page,s);check(p,`Missing sound hit area${s.channel}`);positions.set(s.channel,p);
  }
  const progress=[];
  for(const [sound,channels] of pairs) {
    check(channels.length===2,`Sound pair ${sound} is malformed`);
    for(const channel of channels){await click(page,...positions.get(channel));await page.waitForTimeout(200);}
    await move(page,320,200);
    await page.waitForTimeout(1900);
    const left=await globalValue(page,'antalkvar');progress.push({sound,channels,left});
    console.log('Matched',sound,'remaining',left);
    check(left===12-progress.length,'Matching pair did not reduce remaining count');
  }
  await page.waitForTimeout(3500);
  const completed=await save(page,'DAG03-completed',{progress});
  check(completed.context.current_frame===7,'Matching all sounds did not complete the game');
  check(completed.errors.length===0&&page.errors.length===0,'Runtime error during memory game');
  await click(page,390,445);await move(page,320,200);await page.waitForTimeout(1000);
  check(await globalValue(page,'antalkvar')===12,'Restart did not reset all pairs');
  await click(page,210,445);await move(page,320,200);await page.waitForTimeout(2000);
  const returned=await save(page,'DAG03-return');
  check(returned.execution.movie_name.toLowerCase().includes('kalender'),'Return to calendar failed');
  console.log('DAG03: 12 pairs, completion, restart, calendar return passed.');
}catch(error){console.error(error);await save(page,'DAG03-failure',{error:String(error)});process.exitCode=1;}
finally{await browser.close();}
