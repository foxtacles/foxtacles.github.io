import {chromium,openGame,startPlay,click,move,snapshot,globalValue,save,check,dragSprite,waitMovie} from './play_helpers.mjs';
const first=Number(process.argv[2]||6),second=Number(process.argv[3]||9);
const browser=await chromium.launch();const page=await openGame(browser,'DAG12');
const stages=[],placements=[];let sawFinal=false;
try {
  await startPlay(page);await move(page,320,410);
  const deadline=Date.now()+180000;
  while(Date.now()<deadline){
    const value=await globalValue(page,'gameStage');
    if(value!==stages.at(-1)){stages.push(value);console.log('Baking stage',value);}
    const current=await snapshot(page);
    check(current.errors.length===0&&page.errors.length===0,'Baking runtime error');
    if(value>=11)sawFinal=true;
    if(sawFinal&&value<2)break;
    const hold=await globalValue(page,'holdStage');
    const which=value===3.5?first:value===5.5?second:null;
    if(which&&hold===1&&!placements.includes(which)){
      const sprite=current.stage.sprites.find(s=>s.channel===which);
      const bowl=current.stage.sprites.find(s=>s.channel===13);
      check(sprite&&bowl,'Missing ingredient or bowl');
      const target=[(bowl.rect[0]+bowl.rect[2])/2,bowl.rect[1]+40-(sprite.rect[3]-sprite.y)];
      await dragSprite(page,sprite,target);await move(page,320,410);await page.waitForTimeout(300);
      const ingredients=await globalValue(page,'ingredientList');
      check(ingredients.includes(which),'Ingredient was not accepted in bowl');
      placements.push(which);
    }
    await page.waitForTimeout(500);
  }
  const completed=await save(page,`DAG12-${first}-${second}-completed`,{stages,placements,sawFinal});
  check(sawFinal&&placements.length===2,'Baking did not reach result with both ingredients');
  await click(page,210,445);await move(page,320,410);await waitMovie(page,'kalender');
  const returned=await save(page,`DAG12-${first}-${second}-return`);
  check(returned.execution.movie_name.toLowerCase().includes('kalender'),'Baking calendar return failed');
  console.log('Baking completed',first,second);
}catch(error){console.error(error);await save(page,`DAG12-${first}-${second}-failure`,{stages,placements,error:String(error)});process.exitCode=1;}
finally{await browser.close();}
