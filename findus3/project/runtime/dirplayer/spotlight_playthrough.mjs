import {chromium,openGame,startPlay,click,move,snapshot,globalValue,save,check} from './play_helpers.mjs';
const browser=await chromium.launch();const page=await openGame(browser,'DAG08');
try {
  await startPlay(page);await move(page,320,200);
  const selected=await globalValue(page,'SlumpMonsterList');
  check(selected?.length===3,'Spotlight game did not initialize3 creatures');
  const positions=[[133,130],[205,185],[360,327],[69,355],[596,260],[210,48],[450,380],[352,166]];
  const progress=[];
  for(const id of selected){
    await move(page,...positions[id-1]);await page.mouse.down();
    const deadline=Date.now()+14000;
    while(Date.now()<deadline){
      await page.waitForTimeout(250);
      const found=await globalValue(page,'AntalHittade');
      const active=await globalValue(page,'HittatAktiv');
      if(found===progress.length+1&&active===0)break;
    }
    await page.mouse.up();
    const found=await globalValue(page,'AntalHittade');
    progress.push({id,found});console.log('Found',id,found);
    check(found===progress.length,'Creature capture failed');
  }
  await page.waitForTimeout(1000);
  const completed=await save(page,'DAG08-completed',{selected,progress});
  check(await globalValue(page,'SpeletSlut')===1,'Three captures did not complete spotlight game');
  check(completed.errors.length===0&&page.errors.length===0,'Runtime errors during spotlight');
  await click(page,390,445);await move(page,320,200);await page.waitForTimeout(1000);
  check(await globalValue(page,'AntalHittade')===0,'Spotlight restart did not reset captures');
  await click(page,210,445);await move(page,320,200);await page.waitForTimeout(2500);
  const returned=await save(page,'DAG08-return');
  check(returned.execution.movie_name.toLowerCase().includes('kalender'),'Spotlight calendar return failed');
  console.log('DAG08:3 captures, completion, restart, calendar return passed.');
}catch(error){console.error(error);await save(page,'DAG08-failure',{error:String(error)});process.exitCode=1;}
finally{await browser.close();}
