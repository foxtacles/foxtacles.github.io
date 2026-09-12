import {chromium,openGame,startPlay,click,move,snapshot,globalValue,save,check,dragSprite,grabPoint,waitMovie} from './play_helpers.mjs';
const browser=await chromium.launch();const page=await openGame(browser,'DAG11');
try {
  await startPlay(page);await move(page,320,410);
  const initial=await save(page,'DAG11-start');
  const names=['Ett','Tva','Tre'];const progress=[];
  page.traceDrag=[];
  check(await globalValue(page,'klar')===0,'Rhyme game did not initialize');
  for(const suffix of names){
    const channel=await globalValue(page,'sprite'+suffix),rim=await globalValue(page,'rim'+suffix);
    const current=await snapshot(page);const sprite=current.stage.sprites.find(s=>s.channel===channel);const target=current.stage.sprites.find(s=>s.channel===rim);
    check(sprite&&target,'Missing rhyme object/target');
    const targetPoint=await grabPoint(page,target);check(targetPoint,'No rhyme hit area');
    await click(page,...targetPoint);
    await page.waitForTimeout(500);
    await dragSprite(page,sprite,[targetPoint[0]+1,targetPoint[1]+1]);
    await move(page,320,410);await page.waitForTimeout(500);
    const matched=await globalValue(page,'klar');progress.push({channel,rim,matched});console.log('Rhyme matched',matched);
    check(matched===progress.length,'Correct rhyme placement was not accepted');
  }
  await page.waitForTimeout(5000);
  const completed=await save(page,'DAG11-completed',{progress});
  check(completed.errors.length===0&&page.errors.length===0,'Rhyme runtime errors');
  check(completed.context.current_frame!==initial.context.current_frame,'Rhyme completion did not advance');
  await click(page,390,445);await move(page,320,410);await page.waitForTimeout(3500);
  check(await globalValue(page,'klar')===0,'Rhyme restart failed');
  await save(page,'DAG11-restarted');
  await click(page,210,445);await move(page,320,410);await waitMovie(page,'kalender');
  const returned=await save(page,'DAG11-return');
  check(returned.execution.movie_name.toLowerCase().includes('kalender'),'Rhyme calendar return failed');
  console.log('DAG11:all3 rhyme matches, completion, calendar return passed.');
}catch(error){console.error(error);await save(page,'DAG11-failure',{error:String(error),trace:page.traceDrag});process.exitCode=1;}
finally{await browser.close();}
