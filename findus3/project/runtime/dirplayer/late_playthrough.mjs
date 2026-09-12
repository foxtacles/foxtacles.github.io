import {chromium} from '../../tools/runtime-options/dirplayer-rs/node_modules/playwright/index.mjs';
import fs from 'node:fs/promises';
import path from 'node:path';
import {createHash} from 'node:crypto';

const naturalStory=process.env.FINDUS_NATURAL_STORY==='1';
const output=path.resolve('artifacts/runtime-tests/web/late-gameplay'+(naturalStory?'-natural':''));
await fs.mkdir(output,{recursive:true});
const engineSha256=createHash('sha256').update(await fs.readFile('dist/web/engine/vm_rust_bg.wasm')).digest('hex');
const browser=await chromium.launch({headless:true});
function solveSliding(cells,size){
  const start=cells.join(''),goal=[...Array(cells.length-1)].map((_,i)=>i+1).concat(0).join('');
  const queue=[start],seen=new Map([[start,null]]);
  for(let head=0;head<queue.length;head++){
    const board=queue[head];
    if(board===goal){const moves=[];for(let s=goal;s!==start;){const [parent,move]=seen.get(s);moves.push(move);s=parent;}return moves.reverse();}
    const empty=board.indexOf('0'),row=Math.floor(empty/size),col=empty%size;
    for(const next of [row?empty-size:-1,row<size-1?empty+size:-1,col?empty-1:-1,col<size-1?empty+1:-1].filter(x=>x>=0)){
      const chars=board.split('');[chars[empty],chars[next]]=[chars[next],chars[empty]];
      const candidate=chars.join('');if(!seen.has(candidate)){seen.set(candidate,[board,next]);queue.push(candidate);}
    }
  }
  throw Error('Sliding puzzle has no reachable goal');
}
const targets=process.argv.slice(2);
const supported=['DAG13','DAG20','DAG21','DAG22','DAG23','DAG24'];
for(const movie of targets.length?targets:(naturalStory?['DAG24']:supported)){
  if(!supported.includes(movie))throw Error(`No focused gameplay scenario for ${movie}`);
  const page=await browser.newPage({viewport:{width:1000,height:800}});
  const report={movie,naturalStory,engineSha256,startedAt:new Date().toISOString(),actions:[],checkpoints:[],errors:[]};
  page.setDefaultTimeout(15000);
  page.on('pageerror',e=>report.errors.push(String(e)));
  const stage=page.locator('#stage_canvas_container');
  async function scene(){return await page.evaluate(()=>JSON.parse(window.findus.vm.get_stage_snapshot()));}
  async function globals(){return await page.evaluate(()=>JSON.parse(window.findus.vm.mcp_get_globals()).globals);}
  async function click(x,y){
    report.actions.push({type:'click',x,y});
    const b=await stage.boundingBox();
    await page.mouse.move(b.x+b.width*x/640,b.y+b.height*y/480);
    await page.waitForTimeout(120);
    await page.mouse.down();await page.waitForTimeout(100);await page.mouse.up();
  }
  async function spritePoint(sprite){
    const point=await page.evaluate(({rect,channel})=>{
      const [l,t,r,b]=rect;
      const fractions=[.5,.25,.75,.1,.9,.375,.625];
      for(const fy of fractions)for(const fx of fractions){
        const x=l+(r-l)*fx,y=t+(b-t)*fy;
        if(window.findus.vm.player_get_mouse_sprite_at(x,y)===channel)return[x,y];
      }
      for(let y=Math.max(0,t+1);y<Math.min(480,b);y+=3)for(let x=Math.max(0,l+1);x<Math.min(640,r);x+=3){
        if(window.findus.vm.player_get_mouse_sprite_at(x,y)===channel)return[x,y];
      }
      return null;
    },sprite);
    if(!point)throw Error(`No visible scripted hit point for sprite ${sprite.channel}`);
    return point;
  }
  async function clickSprite(sprite){await click(...await spritePoint(sprite));}
  async function drag(from,to,steps=18){
    report.actions.push({type:"drag",from,to}); const b=await stage.boundingBox();
    const at=([x,y])=>[b.x+b.width*x/640,b.y+b.height*y/480];
    await page.mouse.move(...at(from));await page.waitForTimeout(160);await page.mouse.down();await page.waitForTimeout(180);
    for(let i=1;i<=steps;i++){await page.mouse.move(...at([from[0]+(to[0]-from[0])*i/steps,from[1]+(to[1]-from[1])*i/steps]));await page.waitForTimeout(70);}
    await page.waitForTimeout(150);await page.mouse.up();await page.waitForTimeout(250);
  }
  async function checkpoint(name){
    const state=await page.evaluate(()=>({...window.findus.snapshot(),stage:JSON.parse(window.findus.vm.get_stage_snapshot())}));
    report.checkpoints.push({name,state});
    await stage.screenshot({path:path.join(output,`${movie}-${name}.png`)});
    console.log(`${movie}: ${name} ${state.execution.movie_name} frame${state.execution.current_frame}`);
  }
  async function waitGlobal(name,expected){
    await page.waitForFunction(([name,expected])=>JSON.parse(window.findus.vm.mcp_get_globals()).globals[name]?.value===String(expected),[name,expected]);
  }
  async function listGlobal(name){return await page.evaluate(name=>{
    const value=JSON.parse(window.findus.vm.mcp_get_globals()).globals[name].value;
    return Array.from(value.matchAll(/DatumRef\((\d+)\)/g),m=>Number(JSON.parse(window.findus.vm.mcp_inspect_datum(Number(m[1]))).value));
  },name);}
  async function waitFrame(frame){await page.waitForFunction(frame=>JSON.parse(window.findus.vm.get_stage_snapshot()).frame===frame,frame);}
  try{
    await page.goto(`${process.env.FINDUS_TEST_URL||'http://127.0.0.1:8766/'}?movie=${movie}`);
    await page.waitForFunction(()=>window.findus?.state.ready);
    await page.locator('#start').click();await page.waitForTimeout(1800);
    await click(410,452);
    if(movie!=='DAG13') {await page.waitForTimeout(700);await click(410,452);}
    if(movie==='DAG13'){
      await waitFrame(14);await page.waitForTimeout(300);
      await checkpoint('deck');
      const initial=await scene();
      const sprites=new Map(initial.sprites.map(s=>[s.channel,s]));
      for(let i=3;i<=10;i++){
        if(sprites.get(i).cast!==1)throw Error(`Card back ${i} has invalid cast ${sprites.get(i).cast}`);
        const picture=sprites.get(i+11);
        const partner=initial.sprites.find(s=>s.channel>=37&&s.channel<=44&&s.member===picture.member+20);
        if(!partner)throw Error(`No matching picture for card ${i}`);
        await clickSprite(sprites.get(i));await page.waitForTimeout(1100);
        await clickSprite(sprites.get(partner.channel-11));
        await waitGlobal('gant_par',i-2);await page.waitForTimeout(1000);
        console.log(`${movie}: matched ${i-2}/8`);
      }
      await page.waitForTimeout(1500);
      await checkpoint('all-eight-pairs');
      report.gameplay='All eight matching pairs accepted through pointer input';
    }else if(movie==='DAG22'){
      await waitFrame(10);await page.waitForTimeout(400);await checkpoint('unpainted');
      const initial=await scene();
      // Select each paint pot through its authored mouseUp handler, then paint
      // visible ornaments through their actual mouseDown dispatch.
      for(let color=0;color<4;color++){
        const pot=initial.sprites.find(s=>s.channel===25+color);
        await clickSprite(pot);await waitGlobal('gFarg',color+1);
        for(const s of initial.sprites.filter(s=>s.channel>=10&&s.channel<23&&((s.channel-10)%4)===color)){
          await clickSprite(s);await page.waitForTimeout(250);
        }
      }
      await page.waitForTimeout(700);await checkpoint('painted');
      const painted=(await scene()).sprites.filter(s=>s.channel>=10&&s.channel<23);
      report.painted=painted.map(s=>({channel:s.channel,member:s.member}));
      if(painted.some(s=>s.member<40))throw Error('Some ornaments did not receive paint at their visible center');
      report.gameplay='All thirteen ornaments painted with four palette choices';
    }else if(movie==='DAG20'){
      await waitFrame(5);await checkpoint('undecorated');
      const flags={3:'tre',4:'fyra',5:'fem',6:'sex',7:'sju',8:'atta',9:'nio',10:'tio',13:'tretton',14:'fjorton',15:'femton',16:'sexton',17:'sjutton'};
      for(const [channel,flag] of Object.entries(flags)){
        const sprite=(await scene()).sprites.find(s=>s.channel===Number(channel));
        const point=await spritePoint(sprite);
        await drag(point,[point[0]+310-sprite.x,point[1]+260-sprite.y]);
        await waitGlobal(flag,1);console.log(`${movie}: accepted ${flag}`);
      }
      await waitFrame(8);await checkpoint('all-thirteen-decorations');
      report.gameplay='Placed all thirteen decorations on the tree through pointer drags';
    }else if(movie==='DAG23'){
      await waitFrame(20);await checkpoint('original-dance');
      const findus=await page.evaluate(()=>{const id=JSON.parse(window.findus.vm.mcp_get_globals()).globals.gFindus.datum_id;return JSON.parse(window.findus.vm.mcp_inspect_datum(id));});
      report.findus=findus;
      const props=findus.properties; const sn=Number(props.spriteNum.value);
      const sprite=(await scene()).sprites.find(s=>s.channel===sn);
      const from=[(sprite.rect[0]+sprite.rect[2])/2,(sprite.rect[1]+sprite.rect[3])/2];
      await drag(from,[500,330],36);
      await waitFrame(20);await checkpoint('recorded-dance');
      const g=await globals();report.pathLength=Number(g.gPathLen.value);
      if(report.pathLength<10||report.pathLength>=1000)throw Error(`New path did not record: ${report.pathLength}`);
      const pos=Number(g.gPathPos.value);await page.waitForTimeout(700);const after=Number((await globals()).gPathPos.value);
      if(pos===after)throw Error('Recorded dance path does not advance');
      report.gameplay=`Recorded and replayed a ${report.pathLength}-point dance path through pointer dragging`;
    }else if(movie==='DAG24'){
      await waitFrame(29);
      async function nextPage(){const arrow=(await scene()).sprites.find(s=>s.channel===101);await clickSprite(arrow);await page.waitForTimeout(1000);}
      await page.waitForFunction(()=>JSON.parse(window.findus.vm.mcp_get_globals()).globals.AktLjudAvsnitt?.value==='1');
      await checkpoint('story-chapter1');
      if(naturalStory) await page.waitForFunction(()=>JSON.parse(window.findus.vm.get_stage_snapshot()).frame===65,null,{timeout:360000});
      else for(let i=0;i<5&&(await scene()).frame<60;i++){await nextPage();}
      await page.waitForFunction(()=>JSON.parse(window.findus.vm.mcp_get_globals()).globals.WheelSpriteNr);
      await checkpoint('machine-unassembled');
      for(const [channel,target] of [[20,[343,245]],[25,[264,248]],[21,[343,245]],[26,[264,248]]]){
        const sprite=(await scene()).sprites.find(s=>s.channel===channel),from=await spritePoint(sprite);
        await drag(from,[from[0]+target[0]-sprite.x,from[1]+target[1]-sprite.y]);
        console.log(`${movie}: wheel ${channel}, OnPos=${await listGlobal('OnPos')}`);
      }
      await waitGlobal('MaskinAktiv',1);await page.waitForTimeout(1600);await checkpoint('machine-running');
      await nextPage();
      if(naturalStory) await page.waitForFunction(()=>JSON.parse(window.findus.vm.get_stage_snapshot()).frame===37,null,{timeout:360000});
      else for(let i=0;i<4&&!((await scene()).frame>=35&&(await scene()).frame<40);i++){await nextPage();}
      await page.waitForFunction(()=>JSON.parse(window.findus.vm.mcp_get_globals()).globals.tomtearea);
      await checkpoint('santa-undressed');
      for(const channel of [42,48,70,66]){
        const sprite=(await scene()).sprites.find(s=>s.channel===channel),from=await spritePoint(sprite);
        await drag(from,[from[0]+324-sprite.x,from[1]+251-sprite.y]);
        console.log(`${movie}: Santa ${channel}, parts=${await listGlobal('TomteSprites')}`);
      }
      const parts=await listGlobal('TomteSprites');if(parts.length!==4||parts.some(p=>p===0))throw Error(`Santa incomplete: ${parts}`);
      await checkpoint('santa-dressed');
      await nextPage();
      if(naturalStory) await page.waitForFunction(()=>JSON.parse(window.findus.vm.get_stage_snapshot()).frame>=40&&JSON.parse(window.findus.vm.get_stage_snapshot()).frame<60,null,{timeout:360000});
      else for(let i=0;i<4&&(await scene()).frame<40;i++){await nextPage();}
      await checkpoint('story-finale');
      if(naturalStory){await page.waitForFunction(()=>JSON.parse(window.findus.vm.get_stage_snapshot()).frame===55,null,{timeout:360000});await checkpoint('narration-finished');}
      report.gameplay=naturalStory?'Allowed all nine main story chapters and concluding narration/animation to finish naturally; assembled wheels and dressed Santa; reached final hold frame55':'Navigated story chapters, assembled and ran all four machine wheels, dressed Santa with four part classes, continued to the finale';
    }else if(movie==='DAG21'){
      await waitFrame(20);await checkpoint('scrambled');
      const before=await globals();
      const size=Number(before.gGameSize.value),tile=Number(before.gTileSize.value);
      const x=Number(before.gGameXPos.value),y=Number(before.gGameYPos.value);
      const cells=await page.evaluate(()=>{
        const refs=JSON.parse(window.findus.vm.mcp_get_globals()).globals.gTileArray.value.matchAll(/DatumRef\((\d+)\)/g);
        return Array.from(refs,ref=>Number(JSON.parse(window.findus.vm.mcp_inspect_datum(Number(ref[1]))).value));
      });
      const moves=solveSliding(cells,size);report.solution={initial:cells,moves};
      for(const next of moves){
        await click(x+(next%size+.5)*tile,y+(Math.floor(next/size)+.5)*tile);
        await waitGlobal('gEmptyPos',next+1);
        await page.waitForTimeout(200);
      }
      await page.waitForFunction(()=>JSON.parse(window.findus.vm.get_stage_snapshot()).frame!==20);
      await checkpoint('solved-puzzle');
      report.gameplay=`Solved 3×3 puzzle in ${moves.length} legal pointer moves`;
    }
    await click(220,452);await page.waitForTimeout(700);
    await page.waitForFunction(()=>JSON.parse(window.findus.vm.mcp_get_execution_state()).movie_name.toLowerCase().startsWith('kalender'),{},{timeout:15000});
    await page.waitForTimeout(1000);await checkpoint('calendar-return');
    if(report.errors.length||report.checkpoints.some(c=>c.state.errors.length))throw Error('VM errors captured');
    report.status='passed';
  }catch(error){report.status='failed';report.error=String(error);try{await checkpoint('failure');}catch{}}
  await fs.writeFile(path.join(output,`${movie}.json`),JSON.stringify(report,null,2));
  console.log(JSON.stringify({movie,status:report.status,gameplay:report.gameplay,error:report.error}));
  await page.close();
}
await browser.close();
