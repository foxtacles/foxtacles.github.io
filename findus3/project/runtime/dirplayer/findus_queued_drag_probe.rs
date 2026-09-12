use vm_rust::player::{testing::{run_test,TestPlayer},reserve_player_mut,reserve_player_ref,commands::{run_player_command,PlayerVMCommand},score::SpriteChannel};
fn main(){
 vm_rust::player::symbols::symbol_table::init_symbol_table();
 run_test(async {
  let _harness=TestPlayer::new();
  reserve_player_mut(|p| {
   p.is_playing=true;p.movie.mouse_down=false; // Host has received release before draining commands.
   p.click_on_sprite=1;p.drag_offset=(2,3);
   p.movie.score.channels=(0..2).map(SpriteChannel::new).collect();
   let s=p.movie.score.get_sprite_mut(1);s.moveable=true;s.loc_h=10;s.loc_v=20;
  });
  // This move was physically received before release, while the button was held.
  run_player_command(PlayerVMCommand::MouseMove((100,200),true)).await.unwrap();
  reserve_player_ref(|p| {
   let s=p.movie.score.get_sprite(1).unwrap();
   assert_eq!((s.loc_h,s.loc_v),(102,203),"queued pre-release drag must reach its final position");
  });
  println!("PASS: final drag motion survives synchronous physical release");
 });
}
