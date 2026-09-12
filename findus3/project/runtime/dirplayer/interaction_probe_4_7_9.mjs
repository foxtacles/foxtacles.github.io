import {chromium} from '../../tools/runtime-options/dirplayer-rs/node_modules/playwright/index.mjs';
import {mkdir,writeFile} from 'node:fs/promises';
const out=new URL('../../artifacts/runtime-tests/interactions-4-7-9/',import.meta.url);
await mkdir(out,{recursive:true});
const browser=await chromium.launch({headless:true});
const movies=process.argv.slice(2).length?process.argv.slice(2):['DAG04','DAG07','DAG09'];
await Promise.all(movies.map(async movie=>{
 const page=await browser.newPage({viewport:{width:1000,height:900}}),events=[];
 page.on('pageerror',e=>events.push(String(e)));
 page.on('console',m=>{if(m.type()==='error')events.push(m.text());});
 try{
  await page.goto(`http://127.0.0.1:8766/?movie=${movie}`);
  await page.locator('#start').click({timeout:45000});
  await page.waitForTimeout(8000);
  const menu=await page.evaluate(()=>window.findus.snapshot());
  await page.screenshot({path:new URL(`${movie}-menu.png`,out).pathname});
  const stage=await page.locator('#stage_canvas_container').boundingBox();
  const click=async(x,y)=>page.mouse.click(stage.x+x*stage.width/640,stage.y+y*stage.height/480,{delay:150});
  await click(390,445);
  await page.waitForTimeout(5000);
  const playing=await page.evaluate(()=>window.findus.snapshot());
  await page.screenshot({path:new URL(`${movie}-playing.png`,out).pathname});
  await writeFile(new URL(`${movie}.json`,out),JSON.stringify({menu,playing,events},null,2));
  console.log(movie,JSON.stringify({menu:menu.context,playing:playing.context,errors:playing.errors}));
 }catch(error){console.log(movie,String(error));await writeFile(new URL(`${movie}-error.json`,out),JSON.stringify({error:String(error),events},null,2));}
 await page.close();
}));
await browser.close();
