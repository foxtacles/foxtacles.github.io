import init, * as vm from './engine/vm_rust.js';
import {registerVmCallbacks, setVmModule, setXtraMovieBase, whenMovieLoaded} from 'dirplayer-js-api';

const $ = id => document.getElementById(id);
const params = new URLSearchParams(location.search);
const base = new URL('./', location.href);
const gameBase = new URL('game/', base);
const state = {ready:false, playing:false, movie:null, frame:0, loads:[], errors:[], messages:[], score:null, channels:{}};
const timers = new Map();
const heldButtons=new Map();
let context;
let muted=false;
const report = (kind, value) => {
  state[kind].push(value);
  if (state[kind].length > 300) state[kind].shift();
  if(kind === 'errors') {
    console.error('Findus:', value);
    $('diagnostic-output').textContent = JSON.stringify(value, null, 2);
    $('diagnostics').open = true;
  }
};
// Director resolves filenames case-insensitively and substitutes DIR/DXR/DCR
// and CST/CXT/CCT. Map only game URLs so the same package works on static hosts.
const manifest = await fetch(new URL('game/files.json',base)).then(r=>r.json());
const originalFetch = window.fetch.bind(window);
window.fetch = (input, options) => {
  const url = new URL(typeof input === 'string' ? input : input.url || input, location.href);
  if(url.origin === gameBase.origin && url.pathname.startsWith(gameBase.pathname)) {
    const key = decodeURIComponent(url.pathname.slice(gameBase.pathname.length)).toLowerCase();
    const canonical = manifest[key];
    if(canonical) {
      const target = new URL(canonical,gameBase);
      input = input instanceof Request ? new Request(target,input) : target;
    }
  }
  return originalFetch(input,options);
};
registerVmCallbacks(new Proxy({
  onMovieLoaded(movie) { state.movie=movie;state.loads.push(movie); },
  onMovieLoadFailed(path,error) {report('errors',{path,error});$('status').textContent='Das Spiel konnte nicht geladen werden.';},
  onFrameChanged(frame) {state.frame=frame;},
  onScoreChanged(score) {state.score=score;},
  onChannelChanged(channel,data) {state.channels[channel]=data;},
  onScriptError(error) {report('errors',error);},
  onDebugMessage(message) {report('messages',message);},
  onScheduleTimeout(name,period) {clearInterval(timers.get(name));timers.set(name,setInterval(()=>vm.trigger_timeout(name),period));},
  onClearTimeout(name) {clearInterval(timers.get(name));timers.delete(name);},
  onClearAllTimeouts() {for(const timer of timers.values())clearInterval(timer);timers.clear();},
  onStageSizeChanged(width,height) {state.stageSize=[width,height];},
}, {get:(target,key)=>target[key] || (()=>{})}));
// The VM asks for this context during initialization. Resume on the Start gesture.
context = new (window.AudioContext || window.webkitAudioContext)();
window.getAudioContext = () => context;
try {
  await init({module_or_path:new URL('engine/vm_rust_bg.wasm',base)});
  setVmModule(vm);
  vm.set_system_font_path(new URL('engine/charmap-system.png',base).href);
  vm.player_create_canvas();
  vm.set_stage_size(640,480);
  if(params.has('renderer')) vm.set_renderer_backend(params.get('renderer'));
  vm.set_break_on_error(true);
  state.ready=true;
  $('start').disabled=false;
  $('start').textContent='Spielen';
} catch(error) {report('errors',String(error));$('status').textContent=String(error);}

async function load(movie='start') {
  const relative=movie.toLowerCase()==='start'?'start.dir':`main/${movie.toLowerCase()}.dxr`;
  const path=new URL(relative,gameBase);
  vm.set_base_path(new URL('./',path).href);
  setXtraMovieBase(new URL('./',path).href);
  const loaded=whenMovieLoaded();
  vm.load_movie_file(path.href,false);
  await loaded;
  vm.play();
  state.playing=true;
}
$('start').onclick=async()=>{
  $('start').disabled=true;
  await context.resume();
  const audio=new vm.WebAudioBackend();audio.resume_context();
  vm.set_external_params($('all-days').checked ? {findusDate:'2000-12-24'} : {});
  $('welcome').hidden=true;
  $('sound').disabled=false;
  $('stage_canvas_container').focus();
  await load(params.get('movie') || 'start');
};
$('sound').onclick=async()=>{
  muted=!muted;
  vm.set_audio_muted(muted);
  $('sound').textContent=muted?'Ton aus':'Ton an';
  $('sound').setAttribute('aria-label',muted?'Ton einschalten':'Ton ausschalten');
};
$('fullscreen').onclick=async()=>{
  if(document.fullscreenElement){await document.exitFullscreen();return;}
  if($('player').classList.contains('expanded')){
    $('player').classList.remove('expanded');document.body.classList.remove('expanded');return;
  }
  if($('player').requestFullscreen){
    try{await $('player').requestFullscreen();return;}catch{}
  }
  $('player').classList.add('expanded');document.body.classList.add('expanded');
};
function showControls(show) {
  if(!show)for(const id of heldButtons.keys())releaseButton(id);
  $('touch-controls').hidden=!show;
  $('controls').setAttribute('aria-expanded',String(show));
  $('player').classList.toggle('with-controls',show);
}
$('controls').onclick=()=>showControls($('touch-controls').hidden);
showControls(matchMedia('(pointer: coarse)').matches);
const stage=$('stage_canvas_container');
const point=e=>{const r=stage.getBoundingClientRect();return [Math.round((e.clientX-r.left)*640/r.width),Math.round((e.clientY-r.top)*480/r.height)];};
let activePointer;
function releasePointer() {
  if(!activePointer)return;
  const pointer=activePointer;activePointer=null;
  clearTimeout(pointer.release);
  clearTimeout(pointer.press);
  if(pointer.begun)(pointer.right?vm.right_mouse_up:vm.mouse_up)(...pointer.point);
}
function finishPointerWhenReady() {
  if(!activePointer?.begun)return;
  // A touch release may follow a coalesced final move immediately. Let the
  // original low-frame-rate idle handler update its drag/drop hit mask first.
  const delay=activePointer.touch?Math.max(100,120-(performance.now()-activePointer.started)):0;
  if(delay)activePointer.release=setTimeout(releasePointer,delay);else releasePointer();
}
stage.addEventListener('pointermove',e=>{
  if(!state.playing || (activePointer && activePointer.id!==e.pointerId))return;
  const p=point(e);if(activePointer)activePointer.point=p;
  vm.mouse_move(...p);
});
stage.addEventListener('pointerdown',e=>{
  if(!state.playing || (activePointer && !activePointer.release))return;
  releasePointer();e.preventDefault();stage.focus();stage.setPointerCapture(e.pointerId);
  if(context.state!=='running')context.resume().catch(error=>report('errors',String(error)));
  const p=point(e);
  const pointer=activePointer={id:e.pointerId,right:e.button===2,point:p,touch:e.pointerType!=='mouse',begun:false,released:false};
  vm.mouse_move(...p);
  const press=()=>{
    if(activePointer!==pointer)return;
    pointer.begun=true;pointer.started=performance.now();
    // Some score buttons reveal their hit sprite on rollover. Touch has no
    // preceding hover, so allow the original frame handler to reveal it.
    vm.mouse_move(...p);(pointer.right?vm.right_mouse_down:vm.mouse_down)(...p);
    if(pointer.point!==p)vm.mouse_move(...pointer.point);
    if(pointer.released)finishPointerWhenReady();
  };
  if(pointer.touch)pointer.press=setTimeout(press,100);else press();
});
stage.addEventListener('pointerup',e=>{
  if(activePointer?.id!==e.pointerId)return;
  activePointer.point=point(e);
  vm.mouse_move(...activePointer.point);
  // Original Lingo menus poll the mouse button. Preserve a short tap long
  // enough for the authored loop to observe it, without delaying dragging.
  activePointer.released=true;finishPointerWhenReady();
});
stage.addEventListener('pointercancel',e=>{if(activePointer?.id===e.pointerId)releasePointer();});
stage.addEventListener('contextmenu',e=>e.preventDefault());
const keys=new Map();
stage.addEventListener('keydown',e=>{if(!state.playing)return;e.preventDefault();keys.set(e.code,[e.key,e.keyCode]);vm.key_down(e.key,e.keyCode);});
stage.addEventListener('keyup',e=>{if(!state.playing)return;e.preventDefault();keys.delete(e.code);vm.key_up(e.key,e.keyCode);});
stage.addEventListener('blur',()=>{for(const [key,code]of keys.values())vm.key_up(key,code);keys.clear();});
function releaseButton(pointerId) {
  const held=heldButtons.get(pointerId);
  if(!held)return;
  const {button}=held;
  clearTimeout(held.repeat);
  heldButtons.delete(pointerId);
  if(![...heldButtons.values()].some(held=>held.button===button)) {
    button.classList.remove('pressed');
    vm.key_up(button.dataset.key,Number(button.dataset.code));
  }
}
for(const button of $('touch-controls').querySelectorAll('[data-key]')) {
  button.addEventListener('pointerdown',e=>{
    if(!state.playing)return;
    e.preventDefault();button.setPointerCapture(e.pointerId);
    const held={button,repeat:null};
    heldButtons.set(e.pointerId,held);button.classList.add('pressed');
    vm.key_down(button.dataset.key,Number(button.dataset.code));
    if(!['Shift','Control'].includes(button.dataset.key)) {
      const repeat=()=>{
        if(!heldButtons.has(e.pointerId))return;
        vm.key_down(button.dataset.key,Number(button.dataset.code));
        held.repeat=setTimeout(repeat,50);
      };
      held.repeat=setTimeout(repeat,350);
    }
  });
  for(const name of ['pointerup','pointercancel','lostpointercapture'])button.addEventListener(name,e=>releaseButton(e.pointerId));
  button.addEventListener('contextmenu',e=>e.preventDefault());
}
function releaseInputs(){releasePointer();for(const id of heldButtons.keys())releaseButton(id);for(const [key,code] of keys.values())vm.key_up(key,code);keys.clear();}
window.addEventListener('blur',releaseInputs);
document.addEventListener('visibilitychange',()=>{if(document.hidden)releaseInputs();});
// Observable, read-only diagnostics plus the underlying VM for regression tests.
window.findus={vm,state,load,context,snapshot:()=>({context:JSON.parse(vm.mcp_get_context()),execution:JSON.parse(vm.mcp_get_execution_state()),globals:JSON.parse(vm.mcp_get_globals()),errors:state.errors})};
