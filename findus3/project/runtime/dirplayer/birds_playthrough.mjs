import {chromium,openGame,click,move,snapshot,globalValue,save,check,grabPoint,waitMovie} from './play_helpers.mjs';
const browser=await chromium.launch(),page=await openGame(browser,'DAG19');
const actions=[];
const waitFrame=async(number,timeout=20000)=>{const end=Date.now()+timeout;while(Date.now()<end){if((await snapshot(page)).context.current_frame===number)return;await page.waitForTimeout(150);}throw new Error(`Birds frame${number} not reached`);};
try{
  await click(page,390,445);await move(page,320,410);await page.waitForTimeout(3000);
  let state=await save(page,'DAG19-start');console.log('Birds startframe',state.context.current_frame);
  const sequence=await globalValue(page,'randomlista');check(sequence?.length===5,'Missing5-note bird sequence');
  // Init sings all five notes before the next frame accepts the answer.
  const end=Date.now()+30000;
  while(Date.now()<end){state=await snapshot(page);if(state.stage.sprites.filter(s=>s.channel>=3&&s.channel<=5).every(s=>s.visible))break;await page.waitForTimeout(200);}
  await page.waitForTimeout(1500);
  for(const channel of sequence){
    state=await snapshot(page);const sprite=state.stage.sprites.find(s=>s.channel===channel),p=await grabPoint(page,sprite);check(p,'Bird has no click area');
    await click(page,...p);await move(page,320,410);
    const till=Date.now()+15000;
    while(Date.now()<till){await page.waitForTimeout(150);state=await snapshot(page);if(!state.audio.channels.some(c=>c.channel===1&&c.busy))break;}
    actions.push({channel,answer:await globalValue(page,'anvlista'),state});check((await globalValue(page,'anvlista')).length===actions.length,'Correct bird not accepted');
  }
  await page.waitForTimeout(3500);state=await save(page,'DAG19-completed',{sequence,actions});
  check(state.context.current_frame===20,'Birds completion frame not reached');
  await click(page,390,445);await move(page,320,410);await page.waitForTimeout(1000);
  check((await globalValue(page,'anvlista')).length===0,'Birds restart failed');
  await click(page,210,445);await move(page,320,410);await waitMovie(page,'kalender');
  await save(page,'DAG19-return');console.log('DAG19 sequence completion, restart, return passed');
}catch(error){console.error(error);await save(page,'DAG19-failure',{error:String(error),actions});process.exitCode=1;}
finally{await browser.close();}
