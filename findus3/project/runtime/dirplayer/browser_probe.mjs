import { chromium } from '../../tools/runtime-options/dirplayer-rs/node_modules/playwright/index.mjs';
import {mkdir,writeFile} from 'node:fs/promises';
const movies=process.argv.slice(2);
const out=new URL('../../artifacts/runtime-tests/web/',import.meta.url);
await mkdir(out,{recursive:true});
const browser=await chromium.launch({headless:true});
for(const movie of movies.length?movies:['start']) {
  const page=await browser.newPage({viewport:{width:1000,height:900}});
  const events=[];
  page.on('pageerror',e=>events.push({type:'pageerror',message:String(e)}));
  page.on('console',m=>{if(m.type()==='error')events.push({type:'console',message:m.text()});});
  page.on('response',r=>{if(!r.ok())events.push({type:'http',status:r.status(),url:r.url()});});
  try {
    await page.goto(`http://127.0.0.1:8766/?movie=${movie}`);
    await page.locator('#start').click({timeout:45000});
    await page.waitForTimeout(8000);
    const snapshot=await page.evaluate(()=>window.findus.snapshot());
    await page.screenshot({path:new URL(`${movie}.png`,out).pathname});
    let afterPlay=null;
    if(process.env.FINDUS_PLAY==='1' && movie.startsWith('DAG')) {
      const stage=await page.locator('#stage_canvas_container').boundingBox();
      await page.mouse.move(stage.x+390*stage.width/640,stage.y+445*stage.height/480);
      await page.waitForTimeout(200);
      await page.mouse.down();await page.waitForTimeout(150);await page.mouse.up();
      await page.waitForTimeout(500);
      await page.mouse.down();await page.waitForTimeout(150);await page.mouse.up();
      await page.waitForTimeout(5000);
      afterPlay=await page.evaluate(()=>window.findus.snapshot());
      await page.screenshot({path:new URL(`${movie}-playing.png`,out).pathname});
    }
    await writeFile(new URL(`${movie}.json`,out),JSON.stringify({snapshot,afterPlay,events},null,2));
    console.log(movie,JSON.stringify({context:snapshot.context,errors:snapshot.errors,afterPlay:afterPlay?.context,playErrors:afterPlay?.errors,events:events.filter(x=>x.type!=='console').slice(-5)}));
  }catch(error){console.log(movie,String(error));await writeFile(new URL(`${movie}-error.json`,out),JSON.stringify({error:String(error),events},null,2));}
  await page.close();
}
await browser.close();
