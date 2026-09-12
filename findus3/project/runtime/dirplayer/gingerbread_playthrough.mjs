import {chromium,openGame,click,move,snapshot,save,check,dragSprite,globalValue} from './play_helpers.mjs';
const browser=await chromium.launch({headless:true});
const page=await openGame(browser,'DAG14'),actions=[];
const flags=['fyfyra','fyfem','fysex','fysju','fyatta','fynio','fetio','feett','fetva','fetre','fefyra','fefem','fesex','fesju','featta','fenio','setio','seett','setva','setre','sefyra'];
const sprite=async n=>(await snapshot(page)).stage.sprites.find(s=>s.channel===n);
try {
 await click(page,390,450);await move(page,320,410);await page.waitForTimeout(500);
 const first=await sprite(21);await dragSprite(page,first,[400,240]);
 check(await globalValue(page,'klar')===0,'Incorrect structural drop must not count');
 const reset=await sprite(21);check(reset.x===181&&reset.y===159,'Incorrect piece must reset');
 await save(page,'DAG14-invalid-drop');
 let count=0;
 for(const n of [33,32,31,30,29,28,27,26,25,24,21]){
  await dragSprite(page,await sprite(n),[320,240]);await page.waitForTimeout(200);
  count++;const s=await snapshot(page);actions.push({piece:n,state:s});
  check(await globalValue(page,'klar')===count,`Structural piece${n} must count`);
  check(s.errors.length===0,'No structural VM errors');
 }
 await page.waitForTimeout(1200);check((await snapshot(page)).execution.current_frame===10,'Completed house must unlock decorations');
 await save(page,'DAG14-house');
 page.traceDrag=[];
 for(const n of [64,63,62,61,60,59,58,57,56,55,54,53,52,51,50,49,48,47,46,45,44]){
  // Original zone members61/62 contain nonrectangular matte masks.
  // Put house sweets on the walls and garden decorations along the foreground.
  const index=n<=55?n-44:n-56;
  const target=n<=55?[185+40*(index%6),310+40*Math.floor(index/6)]:[145+38*index,414];
  await dragSprite(page,await sprite(n),target);await page.waitForTimeout(150);
  const s=await snapshot(page);actions.push({decoration:n,target,state:s});
  check(await globalValue(page,flags[n-44])===1,`Decoration${n} must be accepted`);
  check(s.errors.length===0,'No decoration VM errors');
 }
 await page.waitForTimeout(1000);check((await snapshot(page)).execution.current_frame===15,'All decorations must reach completion');
 await save(page,'DAG14-complete',{actions});
 await click(page,390,450);await move(page,320,410);await page.waitForTimeout(700);
 check((await snapshot(page)).execution.current_frame===5,'Restart must return to building');check(await globalValue(page,'klar')===0,'Restart clears pieces');
 await save(page,'DAG14-restart');
 await click(page,220,450);await move(page,320,410);await page.waitForTimeout(6500);
 const end=await save(page,'DAG14-return');
 check(end.execution.movie_name.toLowerCase().includes('kalender'),'Calendar return must work');
 check(end.errors.length===0&&page.errors.length===0,'No VM/browser errors');
 console.log('DAG14 passed: invalid drop,11 structural pieces,21 decorations,completion,restart,calendar');
}catch(error){await save(page,'DAG14-failure',{error:String(error),actions,traceDrag:page.traceDrag});throw error;}finally{await browser.close();}
