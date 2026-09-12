import {chromium,openGame,click,move,snapshot,globalValue,save,check,waitMovie} from './play_helpers.mjs';
const browser=await chromium.launch(),page=await openGame(browser,'DAG18');
const phases=[],chapters=new Set();
try{
  await click(page,390,445);await move(page,320,380);
  const deadline=Date.now()+700000;
  while(Date.now()<deadline){
    const b=await globalValue(page,'b'),s=await globalValue(page,'s');const state=await snapshot(page);
    check(state.errors.length===0&&page.errors.length===0,'Narration runtime error');
    const label=`${b}:${s}:${state.context.current_frame}`;
    if(label!==phases.at(-1)?.label){phases.push({label,chapter:b,part:s,frame:state.context.current_frame,audio:state.audio.channels[1]});console.log('Narration',label);}
    if(b>=1&&b<=6&&!chapters.has(b)){chapters.add(b);await save(page,`DAG18-chapter${b}`);}
    if(state.context.current_frame===31)break;
    await page.waitForTimeout(750);
  }
  const final=await save(page,'DAG18-completed',{phases,chapters:[...chapters]});
  check(chapters.size===6&&final.context.current_frame===31,'Full six-chapter narration did not finish');
  await click(page,390,445);await move(page,320,380);await page.waitForTimeout(1000);check(await globalValue(page,'b')===1,'Narration restart failed');
  await click(page,370,410);await move(page,320,380);await page.waitForTimeout(1200);check(await globalValue(page,'b')===2,'Next chapter failed');
  await click(page,250,410);await move(page,320,380);await page.waitForTimeout(1200);check(await globalValue(page,'b')===1,'Previous chapter failed');
  await click(page,210,445);await move(page,320,380);await waitMovie(page,'kalender');await save(page,'DAG18-return',{phases});
  console.log('DAG18 all six narrated chapters, restart, next, previous, return passed');
}catch(error){console.error(error);await save(page,'DAG18-failure',{error:String(error),phases});process.exitCode=1;}
finally{await browser.close();}
