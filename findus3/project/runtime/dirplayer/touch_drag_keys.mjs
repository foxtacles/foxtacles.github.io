import {chromium,devices,openGame,point,snapshot,globalValue,check,waitMovie,grabPoint} from './play_helpers.mjs';
import {mkdir,writeFile} from 'node:fs/promises';
const out=new URL('../../artifacts/runtime-tests/mobile/',import.meta.url);await mkdir(out,{recursive:true});
const browser=await chromium.launch();const results={};
try{
  const page=await openGame(browser,'DAG09',devices['Pixel 7']);const cdp=await page.context().newCDPSession(page);
  const tap=async(x,y)=>{const p=await point(page,x,y);await page.touchscreen.tap(p.x,p.y);await page.waitForTimeout(500);};
  const drag=async(from,to)=>{
    const a=await point(page,...from),b=await point(page,...to),pt=(p)=>({id:1,x:p.x,y:p.y,radiusX:1,radiusY:1,force:1});
    await cdp.send('Input.dispatchTouchEvent',{type:'touchStart',touchPoints:[pt(a)]});await page.waitForTimeout(250);results.trace??=[];results.trace.push({phase:'down',active:await globalValue(page,'aktiv'),state:await snapshot(page)});
    for(let i=1;i<=20;i++){const p={x:a.x+(b.x-a.x)*i/20,y:a.y+(b.y-a.y)*i/20};await cdp.send('Input.dispatchTouchEvent',{type:'touchMove',touchPoints:[pt(p)]});await page.waitForTimeout(25);}
    results.trace.push({phase:'before-release',active:await globalValue(page,'aktiv'),state:await snapshot(page)});await cdp.send('Input.dispatchTouchEvent',{type:'touchEnd',touchPoints:[]});await page.waitForTimeout(650);
  };
  await tap(390,445);await drag([547,375],[100,100]);check(await globalValue(page,'klar')===0,'Invalid touch drop accepted');
  const gestures=[[547,375,372,297],[478,394,297,262],[494,343,253,188],[578,379,359,228],[466,354,355,180],[574,333,339,146],[509,396,321,174]];
  results.tree=[];
  for(const [x,y,tx,ty] of gestures){
    const channel=await page.evaluate(([x,y])=>findus.vm.player_get_sprite_at(x,y),[x,y]);
    const sprite=(await snapshot(page)).stage.sprites.find(s=>s.channel===channel);const grab=await grabPoint(page,sprite);
    await drag(grab,[tx+grab[0]-x,ty+grab[1]-y]);const klar=await globalValue(page,'klar');results.tree.push({channel,klar,grab,stage:(await snapshot(page)).stage});check(klar===results.tree.length,'Touch branch placement failed');}
  check((await snapshot(page)).context.current_frame===15,'Touch tree completion missing');
  await page.screenshot({path:new URL('touch-drag-tree-complete.png',out).pathname});
  await tap(210,445);await waitMovie(page,'kalender');results.treeReturned=true;await page.close();
  const keys=await openGame(browser,'DAG02',devices['Pixel 7']);const keyCdp=await keys.context().newCDPSession(keys);
  const p=await point(keys,390,445);await keys.touchscreen.tap(p.x,p.y);await keys.waitForTimeout(1200);
  const before=await snapshot(keys),names=Object.keys(before.globals.globals),line=names.find(k=>/^l.ngd$/.test(k)),angle=names.find(k=>/^sp.Pos$/.test(k));
  check(line&&angle,'Fishing did not initialize');
  const buttonPoint=async(key,id)=>{const b=await keys.locator(`[data-key="${key}"]`).boundingBox();return{id,x:b.x+b.width/2,y:b.y+b.height/2,radiusX:1,radiusY:1,force:1};};
  const up=await buttonPoint('ArrowUp',1),right=await buttonPoint('ArrowRight',2);
  const deadline=Date.now()+15000;while(Date.now()<deadline&&await globalValue(keys,line)<100)await keys.waitForTimeout(200);
  const read=async()=>({line:await globalValue(keys,line),angle:await globalValue(keys,angle)});
  results.keys={before:await read()};
  await keyCdp.send('Input.dispatchTouchEvent',{type:'touchStart',touchPoints:[up]});
  await keyCdp.send('Input.dispatchTouchEvent',{type:'touchStart',touchPoints:[up,right]});await keys.waitForTimeout(700);
  results.keys.held=await read();check(results.keys.held.line<results.keys.before.line&&results.keys.held.angle!==results.keys.before.angle,'Two simultaneous touch keys did not affect fishing');
  await keyCdp.send('Input.dispatchTouchEvent',{type:'touchCancel',touchPoints:[]});await keys.waitForTimeout(200);results.keys.released=await read();await keys.waitForTimeout(600);results.keys.settled=await read();
  // The original game keeps lowering the line without input; only the rod angle
  // should stop changing. Inspect the live key state independently of animation.
  check(results.keys.released.angle===results.keys.settled.angle,'Cancelled touch keys stuck repeating');check(await keys.locator('.pressed').count()===0,'Pressed touch highlight stuck');
  results.keys.liveAfterCancel=await keys.evaluate(async()=>{const values={};for(const code of [126,124])values[code]=JSON.parse(await findus.vm.mcp_eval_lingo(`keyPressed(${code})`)).result_value;return values;});
  check(Object.values(results.keys.liveAfterCancel).every(value=>String(value)==='0'),'Cancelled touch keys remain physically pressed');
  await keys.screenshot({path:new URL('touch-keys-fishing.png',out).pathname});
  check(keys.errors.length===0&&(await snapshot(keys)).errors.length===0,'Touch keyboard runtime errors');await keys.close();
  results.passed=true;console.log('Real touch: rejected drop,7treepieces,completion/return; two simultaneous keys and cancellation passed');
}catch(error){results.error=String(error);results.passed=false;console.error(error);process.exitCode=1;}
finally{await writeFile(new URL('touch-drag-keys.json',out),JSON.stringify(results,null,2));await browser.close();}
