import {chromium,devices} from '../../tools/runtime-options/dirplayer-rs/node_modules/playwright/index.mjs';
import {mkdir,writeFile} from 'node:fs/promises';
export {chromium,devices};
export const out=new URL('../../artifacts/runtime-tests/playthrough/',import.meta.url);
await mkdir(out,{recursive:true});
export async function openGame(browser,movie,options={}) {
  const page=await browser.newPage({viewport:{width:1000,height:900},...options});
  page.errors=[];
  page.on('pageerror',e=>page.errors.push(String(e)));
  await page.goto(`http://127.0.0.1:8766/?movie=${movie}`);
  await page.locator('#start').click();
  await page.waitForTimeout(8000);
  return page;
}
export async function point(page,x,y){const r=await page.locator('#stage_canvas_container').boundingBox();return {x:r.x+x*r.width/640,y:r.y+y*r.height/480};}
export async function move(page,x,y){const p=await point(page,x,y);await page.mouse.move(p.x,p.y);}
export async function click(page,x,y){await move(page,x,y);await page.waitForTimeout(120);await page.mouse.down();await page.waitForTimeout(120);await page.mouse.up();await page.waitForTimeout(120);}
export async function startPlay(page){for(let i=0;i<2;i++){await click(page,390,445);await move(page,320,240);await page.waitForTimeout(1000);}}
export async function grabPoint(page,sprite) {
  return page.evaluate(s=>{
    const [l,t,r,b]=s.rect;
    const center=[Math.round((l+r)/2),Math.round((t+b)/2)];
    const safe=(x,y)=>[-2,0,2].every(dx=>[-2,0,2].every(dy=>findus.vm.player_get_sprite_at(x+dx,y+dy)===s.channel));
    if(safe(...center))return center;
    let best=null,distance=Infinity;
    for(let y=Math.max(2,t+2);y<Math.min(478,b-2);y+=3)for(let x=Math.max(2,l+2);x<Math.min(638,r-2);x+=3){
      const d=(x-center[0])**2+(y-center[1])**2;
      if(d<distance&&safe(x,y)){best=[x,y];distance=d;}
    }
    if(best)return best;
    for(let y=Math.max(0,t+2);y<Math.min(480,b);y+=3)for(let x=Math.max(0,l+2);x<Math.min(640,r);x+=3){if(findus.vm.player_get_sprite_at(x,y)===s.channel)return[x,y];}
    return null;
  },sprite);
}
export async function dragSprite(page,sprite,target) {
  const grab=await grabPoint(page,sprite);
  check(grab,`No opaque grab point for sprite${sprite.channel}`);
  const dest=[target[0]+grab[0]-sprite.x,target[1]+grab[1]-sprite.y];
  await move(page,...grab);await page.waitForTimeout(100);await page.mouse.down();await page.waitForTimeout(120);
  if(page.traceDrag)page.traceDrag.push({phase:'down',snapshot:await snapshot(page)});
  for(let i=1;i<=15;i++){await move(page,grab[0]+(dest[0]-grab[0])*i/15,grab[1]+(dest[1]-grab[1])*i/15);await page.waitForTimeout(20);}
  await page.waitForTimeout(150);
  if(page.traceDrag)page.traceDrag.push({phase:'before-release',snapshot:await snapshot(page)});
  await page.mouse.up();await page.waitForTimeout(250);
}
export async function snapshot(page){return page.evaluate(()=>({ ...findus.snapshot(),stage:JSON.parse(findus.vm.get_stage_snapshot()),audio:JSON.parse(findus.vm.get_audio_state())}));}
export async function globalValue(page,name){return page.evaluate(name=>{
  const g=JSON.parse(findus.vm.mcp_get_globals()).globals[name];
  if(!g)return null;
  const expand=v=>{
    if(v.type_name==='int'||v.type_name==='float')return Number(v.value);
    if(v.type_name==='string')return v.value.slice(1,-1);
    if(v.type_name==='list')return [...v.value.matchAll(/DatumRef\((\d+)\)/g)].map(m=>expand(JSON.parse(findus.vm.mcp_inspect_datum(Number(m[1])))));
    const d=JSON.parse(findus.vm.mcp_inspect_datum(v.datum_id));
    if(d.properties)return Object.fromEntries(Object.entries(d.properties).map(([k,v])=>[k,expand(v)]));
    return d.value;
  };
  return expand(g);
},name);}
export async function save(page,name,extra={}) {
  await page.screenshot({path:new URL(name+'.png',out).pathname});
  const data={...await snapshot(page),pageErrors:page.errors,...extra};
  await writeFile(new URL(name+'.json',out),JSON.stringify(data,null,2));
  return data;
}
export function check(condition,message){if(!condition)throw new Error(message);}
export async function waitMovie(page,name,timeout=15000){
  const end=Date.now()+timeout;
  while(Date.now()<end){
    const movie=await page.evaluate(()=>JSON.parse(findus.vm.mcp_get_execution_state()).movie_name);
    if(movie.toLowerCase().includes(name.toLowerCase()))return;
    await page.waitForTimeout(200);
  }
  throw new Error(`Did not reach movie ${name}`);
}
