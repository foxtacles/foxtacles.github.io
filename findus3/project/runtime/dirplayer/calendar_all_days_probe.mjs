import {chromium,click,move,snapshot,waitMovie} from './play_helpers.mjs';
import {mkdir,writeFile} from 'node:fs/promises';
import {createHash} from 'node:crypto';
import path from 'node:path';

// Original KALENDER BehaviorScript22 door positions. This intentionally retains
// a single browser page and VM for the whole launcher/calendar/day sequence.
const doors=[[358,233],[477,191],[386,386],[219,324],[104,353],[305,153],
  [339,319],[592,129],[570,347],[90,281],[227,362],[552,266],
  [167,342],[47,218],[454,149],[607,379],[392,320],[403,183],
  [296,294],[391,124],[552,161],[465,310],[424,54],[559,32]];
const out=path.resolve('artifacts/runtime-tests/calendar-all-days');
await mkdir(out,{recursive:true});
const browser=await chromium.launch({headless:true});
const page=await browser.newPage({viewport:{width:1000,height:900}});
const report={engine:browser.version(),started:new Date().toISOString(),singlePage:true,
  originalLauncher:true,events:[],days:[],checks:{}};
page.on('pageerror',error=>report.events.push({type:'pageerror',message:String(error)}));
let engineDigest;
page.on('response',response=>{if(/\.(?:dir|dxr|cxt|cct|dcr)(?:\?|$)/i.test(response.url()))
  report.events.push({type:'asset',url:response.url(),status:response.status()});
  if(response.url().endsWith('/vm_rust_bg.wasm'))engineDigest=response.body().then(body=>{
    report.wasmSha256=createHash('sha256').update(body).digest('hex');
  });
});
async function save(name){
  const value={...await snapshot(page),stack:await page.evaluate(()=>JSON.parse(findus.vm.mcp_get_call_stack(10,true)))};
  await writeFile(path.join(out,name+'.json'),JSON.stringify(value,null,2));
  await page.locator('#stage_canvas_container').screenshot({path:path.join(out,name+'.png')});
  return value;
}
async function writeReport(){await writeFile(path.join(out,'report.json'),JSON.stringify(report,null,2));}
try{
  await page.goto(process.env.FINDUS_TEST_URL || 'http://127.0.0.1:8766/');
  await page.locator('#start').click();
  await waitMovie(page,'kalender',90000);await move(page,320,240);await page.waitForTimeout(2500);
  report.startup=await save('startup-calendar');
  console.log('Original launcher reached calendar');
  for(let index=0;index<doors.length;index++){
    const day=index+1,name='DAG'+String(day).padStart(2,'0');
    const row={day,name,expectedMovie:day===16?'KONSTR01':name,checks:{}};
    report.days.push(row);
    try{
      await move(page,...doors[index]);await page.waitForTimeout(200);
      await click(page,...doors[index]);await page.waitForTimeout(1000);
      await click(page,...doors[index]);await move(page,320,240);
      await waitMovie(page,row.expectedMovie,30000);await page.waitForTimeout(2500);
      row.entry=await save(name+'-entry');row.checks.enteredThroughCalendar=true;
      // Most days share the lower-left authored calendar button. Let entry
      // narration finish before returning so this audit targets movie cleanup.
      await page.waitForFunction(()=>JSON.parse(findus.vm.mcp_get_context()).scope_count===0,
        null,{timeout:45000}).catch(()=>{});
      await click(page,210,445);await move(page,320,240);
      await waitMovie(page,'kalender',25000);await page.waitForTimeout(2500);
      row.return=await save(name+'-return');row.checks.returnedToCalendar=true;
      row.checks.noScriptErrors=!row.entry.errors.length&&!row.return.errors.length;
      if(!row.checks.noScriptErrors)throw new Error('VM reported an error');
      console.log(JSON.stringify({day,checks:row.checks,entryFrame:row.entry.stage.frame}));
      await writeReport();
    }catch(error){row.error=String(error);row.failure=await save(name+'-failure');throw error;}
  }
  report.checks.all24EnteredAndReturned=report.days.length===24&&report.days.every(row=>row.checks.returnedToCalendar);
  report.checks.noScriptOrBrowserErrors=report.days.every(row=>row.checks.noScriptErrors)&&!report.events.some(event=>event.type==='pageerror');
  report.checks.allAssetRequestsSucceeded=report.events.filter(event=>event.type==='asset').every(event=>event.status===200);
}catch(error){report.error=String(error);console.error(error);process.exitCode=1;}
finally{await engineDigest;report.finished=new Date().toISOString();await writeReport();await browser.close();}
