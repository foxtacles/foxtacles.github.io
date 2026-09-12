// Uses original game data only for aiming; all game input is real pointer input.
import {chromium,openGame,move,click,save,check,out} from './play_helpers.mjs';
import {writeFile} from 'node:fs/promises';

async function state(page) {
  return page.evaluate(()=>{
    const s=findus.snapshot(),g=s.globals.globals;
    const number=v=>v?Number(v.value):null;
    const list=v=>[...v.value.matchAll(/DatumRef\((\d+)\)/g)].map(m=>JSON.parse(findus.vm.mcp_inspect_datum(Number(m[1]))));
    const objects=g.gameObjectList?list(g.gameObjectList).map(o=>{
      const p=o.properties;
      return Object.fromEntries(['ObjectNr','aktiv','aktivAction','SpriteNr','posX','posY'].map(k=>[k,number(p[k])]));
    }):[];
    return {frame:s.execution.current_frame,movie:s.execution.movie_name,
      time:number(g.clockTime),score:number(g.AntalPoang),started:number(g.SpeletBorjat),ended:number(g.SpeletSlut),aim:number(g.FindusNr),
      objects,sprites:JSON.parse(findus.vm.get_stage_snapshot()).sprites,errors:s.errors,context:s.context};
  });
}
async function paths(page) {
  return page.evaluate(()=>{
    const inspect=id=>JSON.parse(findus.vm.mcp_inspect_datum(id));
    const list=v=>[...v.value.matchAll(/DatumRef\((\d+)\)/g)].map(m=>inspect(Number(m[1])));
    const chains=list(JSON.parse(findus.vm.mcp_get_globals()).globals.chainList);
    return chains.slice(0,7).map(c=>list(list(c)[3]).map(p=>p.value.match(/-?\d+/g).map(Number)));
  });
}
const browser=await chromium.launch({headless:true});
const page=await openGame(browser,'DAG10'),actions=[],checkpoints=[];
let shots=0,maxScore=0,completed=false;
try {
  await click(page,390,445);await page.waitForTimeout(1200);
  await click(page,566,340);await page.waitForTimeout(1200);
  for(let i=0;i<30&&(await state(page)).frame<6;i++)await page.waitForTimeout(250);
  let s=await state(page);
  check(s.frame===6,'Slingshot gameplay must reach frame6');
  check(s.errors.length===0,'No initial VM errors');
  const arcs=await paths(page);
  await save(page,'DAG10-start',{method:'Read-only original object/path inspection; genuine mouse aiming and presses'});
  const start=Date.now();let lastReport=0,lastShot=0,zeroSeen=false;
  while(Date.now()-start<175000){
    s=await state(page);maxScore=Math.max(maxScore,s.score??0);
    check(s.errors.length===0,'VM errors during slingshot play');
    if(s.time===0||s.ended>0)zeroSeen=true;
    if(zeroSeen&&s.time===120&&s.score===0&&s.started===0){completed=true;break;}
    if(Date.now()-lastReport>10000){
      const compact={elapsed:Date.now()-start,time:s.time,score:s.score,shots,frame:s.frame,ended:s.ended};
      console.log(JSON.stringify(compact));checkpoints.push(compact);lastReport=Date.now();
    }
    if(s.time>0&&s.ended===0&&s.objects[0]?.aktiv===0&&Date.now()-lastShot>350){
      const targets=s.objects.filter(o=>o.ObjectNr>=3&&o.ObjectNr<=7&&o.aktiv===1&&[2,5].includes(o.aktivAction));
      let best=null;
      for(const target of targets){
        const sprite=s.sprites.find(sp=>sp.channel===target.SpriteNr);
        if(!sprite)continue;
        const [l,t,r,b]=sprite.rect;
        for(let aim=0;aim<arcs.length;aim++){
          let distance=Infinity,intersection=false;
          for(const [x,y] of arcs[aim]){
            distance=Math.min(distance,Math.hypot(x-(l+r)/2,y-(t+b)/2));
            if(x+9>l&&x-9<r&&y+6>t&&y-7<b)intersection=true;
          }
          if(!intersection)continue;
          const quality=(target.ObjectNr-2)*10-distance;
          if(!best||quality>best.quality)best={target:target.ObjectNr,aim,quality,rect:sprite.rect};
        }
      }
      if(best){
        const findus=s.sprites.find(sp=>sp.channel===15);
        const x=597-best.aim*7;
        const mouseX=x+(x>findus.x?8:x<findus.x?-8:0);
        await move(page,mouseX,340);await page.waitForTimeout(170);
        const aimed=await state(page);
        actions.push({kind:'aim',...best,actualAim:aimed.aim,time:aimed.time,score:aimed.score});
        if(aimed.aim===best.aim&&aimed.objects[0]?.aktiv===0){
          await page.mouse.down();await page.waitForTimeout(120);await page.mouse.up();
          shots++;lastShot=Date.now();
          if(shots===3)await save(page,'DAG10-scoring',{shots,actions});
        }
      }
    }
    await page.waitForTimeout(80);
  }
  const roundEnd=await state(page);
  await save(page,'DAG10-round-complete',{shots,maxScore,completed,checkpoints});
  check(maxScore>0,'Actual slingshot shots must score');
  check(completed,'120-second round must finish feedback and reset');
  await click(page,580,340);await page.waitForTimeout(1600);
  const restart=await state(page);
  check(restart.started===1&&restart.time<120&&restart.time>110,'Mouse must start a fresh round');
  await save(page,'DAG10-restarted');
  await click(page,240,445);await page.waitForTimeout(7000);
  let calendar=await state(page);
  if(!calendar.movie.toLowerCase().includes('kalender')){
    await click(page,240,445);await page.waitForTimeout(4000);calendar=await state(page);
  }
  await save(page,'DAG10-calendar');
  check(calendar.movie.toLowerCase().includes('kalender'),'Calendar button must navigate back');
  check(calendar.errors.length===0&&page.errors.length===0,'No VM/browser errors');
  await writeFile(new URL('DAG10-result.json',out),JSON.stringify({passed:true,method:'Read-only original projectile paths and target geometry followed by actual pointer aiming and presses; no game-state writes',shots,maxScore,completed,actions,checkpoints,roundEnd,restart,calendar},null,2));
  console.log(`DAG10 passed: ${shots} actual shots, ${maxScore} points, timed completion, restart and calendar return`);
} catch(error){
  await save(page,'DAG10-failure',{error:String(error),actions,checkpoints});
  await writeFile(new URL('DAG10-result.json',out),JSON.stringify({passed:false,error:String(error),shots,maxScore,completed,actions,checkpoints,state:await state(page)},null,2));
  throw error;
} finally { await browser.close(); }
