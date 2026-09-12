import {chromium} from '../../tools/runtime-options/dirplayer-rs/node_modules/playwright/index.mjs';
import {writeFile,mkdir} from 'node:fs/promises';
const browser=await chromium.launch(),page=await browser.newPage();const report={url:'http://127.0.0.1:8768/web/',errors:[],requests:[]};
try{
  page.on('pageerror',e=>report.errors.push(String(e)));
  page.on('requestfailed',r=>report.errors.push(r.url()+': '+r.failure()?.errorText));
  page.on('response',r=>{if(r.url().includes('/game/'))report.requests.push({url:r.url(),status:r.status()});});
  await page.goto(report.url);await page.locator('#start').click();
  await page.waitForFunction(()=>window.findus&&JSON.parse(findus.vm.get_stage_snapshot()).movie.toLowerCase().includes('kalender'),null,{timeout:60000});await page.waitForTimeout(2500);
  report.final=await page.evaluate(()=>findus.snapshot());
  report.passed=report.errors.length===0&&report.final.errors.length===0&&report.requests.every(r=>r.status===200&&r.url.startsWith(report.url+'game/'));
  if(!report.passed)throw new Error('Static subdirectory test failed');
  console.log('Static subdirectory: full startup -> calendar; all game requests remain beneath /web/ and return200.');
}catch(error){report.error=String(error);console.error(error);process.exitCode=1;}
finally{await mkdir('artifacts/runtime-tests/static-host',{recursive:true});await writeFile('artifacts/runtime-tests/static-host/result.json',JSON.stringify(report,null,2));await browser.close();}
