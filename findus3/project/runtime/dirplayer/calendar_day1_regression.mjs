import {chromium,openGame,click,move,snapshot,save,check} from './play_helpers.mjs';
const browser=await chromium.launch({headless:true});
const page=await openGame(browser,'KALENDER');
try {
  await move(page,358,233);await page.waitForTimeout(200);
  await click(page,358,233);await page.waitForTimeout(1000);
  await click(page,358,233);await move(page,320,240);
  await page.waitForFunction(()=>findus.snapshot().execution.movie_name.toLowerCase()==='dag01.dxr',{timeout:20000});
  await page.waitForTimeout(2000);
  const day=await save(page,'DAG01-calendar-entry');
  const background=day.stage.sprites.find(s=>s.channel===3);
  check(background?.member===81&&background.visible,'Calendar channel visibility must not hide day1 background');
  check(day.execution.current_frame>=4&&day.execution.current_frame<=6,'Day1 intro must run');
  check(day.errors.length===0&&page.errors.length===0,'Day1 entry must have no VM/browser errors');
  console.log('PASS: actual calendar door1 entry preserves full day1 pre-game background');
} catch(error){await save(page,'DAG01-calendar-entry-failure',{error:String(error)});throw error;}
finally {await browser.close();}
