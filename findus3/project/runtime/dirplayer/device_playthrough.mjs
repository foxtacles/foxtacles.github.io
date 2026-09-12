import {chromium,webkit,devices} from '../../tools/runtime-options/dirplayer-rs/node_modules/playwright/index.mjs';
import {point,globalValue,grabPoint,snapshot,check,waitMovie} from './play_helpers.mjs';
import {mkdir,writeFile} from 'node:fs/promises';
const out=new URL('../../artifacts/runtime-tests/mobile/',import.meta.url);await mkdir(out,{recursive:true});
const matrix=[['phone-chromium',chromium,'Pixel 7'],['phone-webkit',webkit,'iPhone 13'],['tablet-webkit',webkit,'iPad (gen 7)']];
const selected=process.argv.slice(2);
for(const [name,type,device] of matrix.filter(row=>!selected.length||selected.includes(row[0]))){
  const browser=await type.launch(),page=await browser.newPage({...devices[device]});page.errors=[];
  page.on('pageerror',e=>page.errors.push(String(e)));
  const report={device,browser:browser.version(),checks:[],pairs:[],layouts:[]};
  const tap=async(x,y)=>{const p=await point(page,x,y);await page.touchscreen.tap(p.x,p.y);await page.waitForTimeout(350);};
  const layout=async(label)=>{
    const data=await page.evaluate(()=>({viewport:[innerWidth,innerHeight],bodyWidth:document.body.scrollWidth,fullscreen:!!document.fullscreenElement,expanded:document.getElementById('player').classList.contains('expanded'),controls:!document.getElementById('touch-controls').hidden,stage:document.getElementById('stage_canvas_container').getBoundingClientRect().toJSON(),pad:document.getElementById('touch-controls').getBoundingClientRect().toJSON()}));
    report.layouts.push({label,...data});check(data.bodyWidth<=data.viewport[0]+1,'Horizontal page overflow');
    if(data.fullscreen||data.expanded){for(const rect of [data.stage,data.pad])check(rect.x>=-1&&rect.y>=-1&&rect.right<=data.viewport[0]+1&&rect.bottom<=data.viewport[1]+1,'Fullscreen controls clipped');}
    await page.screenshot({path:new URL(`${name}-${label}.png`,out).pathname});
  };
  try{
    await page.goto('http://127.0.0.1:8766/?movie=DAG03');await page.locator('#start').tap();await page.waitForTimeout(8000);
    await layout('portrait');await tap(390,445);await page.waitForTimeout(800);
    let state=await snapshot(page);check(state.context.current_frame===6,'One short touch tap did not start memory');report.checks.push('short native touch tap starts game');
    await page.locator('#fullscreen').tap();await page.waitForTimeout(500);await layout('portrait-fullscreen');
    await page.locator('#fullscreen').tap();await page.setViewportSize({width:844,height:390});await page.locator('#fullscreen').tap();await page.waitForTimeout(500);await layout('landscape-fullscreen');
    await page.locator('#fullscreen').tap();await page.setViewportSize(devices[device].viewport);await page.waitForTimeout(300);
    const values=await globalValue(page,'slumplistan'),pairs=new Map();values.forEach((sound,i)=>{if(!pairs.has(sound))pairs.set(sound,[]);pairs.get(sound).push(i+10);});
    const positions=new Map();state=await snapshot(page);
    for(const sprite of state.stage.sprites.filter(s=>s.channel>=10&&s.channel<=33))positions.set(sprite.channel,await grabPoint(page,sprite));
    for(const [sound,channels] of pairs){
      for(const channel of channels){await tap(...positions.get(channel));await page.waitForTimeout(150);}
      await page.waitForTimeout(1900);
      const left=await globalValue(page,'antalkvar');report.pairs.push({sound,channels,left});check(left===12-report.pairs.length,'Touch pair not matched');
    }
    await page.waitForTimeout(3500);check((await snapshot(page)).context.current_frame===7,'Touch memory completion missing');report.checks.push('all12 pairs and completion with touch');
    await tap(390,445);await page.waitForTimeout(800);check(await globalValue(page,'antalkvar')===12,'Touch restart failed');
    await tap(210,445);await waitMovie(page,'kalender');report.checks.push('touch restart and calendar return');
    check(page.errors.length===0&&(await snapshot(page)).errors.length===0,'Mobile runtime errors');
    report.passed=true;console.log(name,'passed',report.checks);
  }catch(error){report.passed=false;report.error=String(error);console.error(name,error);process.exitCode=1;}
  finally{report.final=await snapshot(page);report.pageErrors=page.errors;await writeFile(new URL(`${name}-playthrough.json`,out),JSON.stringify(report,null,2));await browser.close();}
}
