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
function releaseCapture(element,id) {
  try{if(element.hasPointerCapture(id))element.releasePointerCapture(id);}catch{}
}
function releasePointer(pointer=activePointer) {
  if(!pointer || activePointer!==pointer)return;
  activePointer=null;
  clearTimeout(pointer.release);
  clearTimeout(pointer.press);
  if(pointer.begun)(pointer.right?vm.right_mouse_up:vm.mouse_up)(...pointer.point);
  releaseCapture(stage,pointer.id);
}
function finishPointerWhenReady(pointer=activePointer) {
  if(!pointer?.begun || activePointer!==pointer)return;
  // A touch release may follow a coalesced final move immediately. Let the
  // original low-frame-rate idle handler update its drag/drop hit mask first.
  const delay=pointer.touch?Math.max(100,120-(performance.now()-pointer.started)):0;
  clearTimeout(pointer.release);
  if(delay)pointer.release=setTimeout(()=>releasePointer(pointer),delay);else releasePointer(pointer);
}
function finishPointer(pointer=activePointer) {
  if(!pointer || activePointer!==pointer || pointer.released)return;
  pointer.released=true;
  finishPointerWhenReady(pointer);
}
stage.addEventListener('pointermove',e=>{
  if(!state.playing || (activePointer && activePointer.id!==e.pointerId))return;
  if(activePointer && e.pointerType==='mouse' && e.buttons===0){releasePointer();return;}
  const p=point(e);if(activePointer)activePointer.point=p;
  vm.mouse_move(...p);
});
stage.addEventListener('pointerdown',e=>{
  if(!state.playing || (activePointer && !activePointer.release))return;
  releasePointer();e.preventDefault();stage.focus();
  try{stage.setPointerCapture(e.pointerId);}catch{}
  if(context.state!=='running')context.resume().catch(error=>report('errors',String(error)));
  const p=point(e);
  const pointer=activePointer={id:e.pointerId,right:e.button===2,point:p,touch:e.pointerType==='touch',begun:false,released:false};
  vm.mouse_move(...p);
  const press=()=>{
    if(activePointer!==pointer)return;
    pointer.begun=true;pointer.started=performance.now();
    // Some score buttons reveal their hit sprite on rollover. Touch has no
    // preceding hover, so allow the original frame handler to reveal it.
    vm.mouse_move(...p);(pointer.right?vm.right_mouse_down:vm.mouse_down)(...p);
    if(pointer.point!==p)vm.mouse_move(...pointer.point);
    if(pointer.released)finishPointerWhenReady(pointer);
  };
  if(pointer.touch)pointer.press=setTimeout(press,100);else press();
});
// Listen above the controls: Safari can retarget the final event when capture
// is interrupted by browser UI or a finger ends outside its original button.
window.addEventListener('pointerup',e=>{
  releaseButton(e.pointerId);
  if(activePointer?.id!==e.pointerId)return;
  activePointer.point=point(e);
  vm.mouse_move(...activePointer.point);
  // Original Lingo menus poll the mouse button. Preserve a short tap long
  // enough for the authored loop to observe it, without delaying dragging.
  finishPointer();
},{capture:true});
window.addEventListener('pointercancel',e=>{
  releaseButton(e.pointerId);
  if(activePointer?.id===e.pointerId)releasePointer();
},{capture:true});
stage.addEventListener('lostpointercapture',e=>{
  // A normal pointerup also loses capture. Keep its short authored tap alive.
  if(activePointer?.id===e.pointerId && !activePointer.released && !stage.hasPointerCapture(e.pointerId))releasePointer();
});
stage.addEventListener('contextmenu',e=>e.preventDefault());
const keys=new Map();
stage.addEventListener('keydown',e=>{if(!state.playing)return;e.preventDefault();keys.set(e.code,[e.key,e.keyCode]);vm.key_down(e.key,e.keyCode);});
function releaseUnusedKey(key,code) {
  if([...keys.values()].some(value=>value[1]===code))return;
  if([...heldButtons.values()].some(held=>Number(held.button.dataset.code)===code))return;
  vm.key_up(key,code);
}
function releaseKeyboard() {
  const released=[...keys.values()];keys.clear();
  for(const [key,code] of released)releaseUnusedKey(key,code);
}
stage.addEventListener('keyup',e=>{if(!state.playing)return;e.preventDefault();keys.delete(e.code);releaseUnusedKey(e.key,e.keyCode);});
stage.addEventListener('blur',releaseKeyboard);
function releaseButton(pointerId) {
  const held=heldButtons.get(pointerId);
  if(!held)return;
  const {button}=held;
  clearTimeout(held.repeat);
  heldButtons.delete(pointerId);
  if(![...heldButtons.values()].some(held=>held.button===button)) {
    button.classList.remove('pressed');
    releaseUnusedKey(button.dataset.key,Number(button.dataset.code));
  }
  releaseCapture(button,pointerId);
}
for(const button of $('touch-controls').querySelectorAll('[data-key]')) {
  button.addEventListener('pointerdown',e=>{
    if(!state.playing)return;
    e.preventDefault();releaseButton(e.pointerId);
    try{button.setPointerCapture(e.pointerId);}catch{}
    const held={button,pointerType:e.pointerType,repeat:null};
    heldButtons.set(e.pointerId,held);button.classList.add('pressed');
    vm.key_down(button.dataset.key,Number(button.dataset.code));
    if(!['Shift','Control'].includes(button.dataset.key)) {
      const repeat=()=>{
        if(heldButtons.get(e.pointerId)!==held)return;
        vm.key_down(button.dataset.key,Number(button.dataset.code));
        held.repeat=setTimeout(repeat,50);
      };
      held.repeat=setTimeout(repeat,350);
    }
  });
  button.addEventListener('lostpointercapture',e=>{
    if(heldButtons.get(e.pointerId)?.button===button && !button.hasPointerCapture(e.pointerId))releaseButton(e.pointerId);
  });
  button.addEventListener('contextmenu',e=>e.preventDefault());
}
// Touch identifiers are not PointerEvent IDs. Reconcile by the original touch
// targets, retaining keys whose fingers are still down instead of releasing
// every key when just one finger ends. This also recovers a missing pointerup.
function reconcileTouches(e) {
  const touches=[...e.touches];
  for(const [id,held] of heldButtons){
    if(held.pointerType==='touch' && !touches.some(touch=>held.button.contains(touch.target)))releaseButton(id);
  }
  if(activePointer?.touch && !touches.some(touch=>stage.contains(touch.target))){
    if(e.type==='touchcancel')releasePointer();
    else {
      const ended=[...e.changedTouches].find(touch=>stage.contains(touch.target));
      if(ended){activePointer.point=point(ended);vm.mouse_move(...activePointer.point);}
      finishPointer();
    }
  }
}
for(const name of ['touchend','touchcancel'])window.addEventListener(name,reconcileTouches,{capture:true,passive:true});
window.addEventListener('pointermove',e=>{
  if(e.pointerType==='mouse' && e.buttons===0)releaseButton(e.pointerId);
},{capture:true});
// Keep native text selection/callouts away from game input, without disabling
// selection in the diagnostics panel.
for(const name of ['selectstart','contextmenu'])$('player').addEventListener(name,e=>{
  if(e.target.closest?.('#game, #touch-controls, button'))e.preventDefault();
});
function releaseInputs(){releasePointer();for(const id of heldButtons.keys())releaseButton(id);releaseKeyboard();}
window.addEventListener('blur',releaseInputs);
window.addEventListener('pagehide',releaseInputs);
window.addEventListener('orientationchange',releaseInputs);
document.addEventListener('fullscreenchange',releaseInputs);
document.addEventListener('visibilitychange',()=>{if(document.hidden)releaseInputs();});
// Observable, read-only diagnostics plus the underlying VM for regression tests.
window.findus={vm,state,load,context,snapshot:()=>({context:JSON.parse(vm.mcp_get_context()),execution:JSON.parse(vm.mcp_get_execution_state()),globals:JSON.parse(vm.mcp_get_globals()),errors:state.errors})};
