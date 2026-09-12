use vm_rust::player::{testing::{TestPlayer,run_test},testing_shared::TestHarness,reserve_player_mut,reserve_player_ref};
use vm_rust::player::allocator::ScriptInstanceAllocatorTrait;
fn main(){
 let path=std::env::args().nth(1).expect("KONSTR01.DXR path");
 run_test(async {
  let mut player=TestPlayer::new();player.load_movie(&path).await;player.init_movie().await;
  player.eval("go(33)").await.unwrap();
  for n in [18,20] {
   let refs=reserve_player_ref(|p|p.movie.score.get_sprite(n).unwrap().script_instance_list.iter().map(|r|p.allocator.get_script_instance(r).script.cast_member).collect::<Vec<_>>());
   assert_eq!(refs,vec![66],"original interstitial behavior");
   player.eval(&format!("sprite({n}).scriptInstanceList")).await.unwrap();
   reserve_player_mut(|p|{let s=p.movie.score.get_sprite_mut(n);s.puppet=true;s.loc_h=123+i32::from(n);s.loc_v=234;s.visible=false;s.blend=37;s.moveable=true;});
  }
  player.eval("go(34)").await.unwrap();
  for n in [18,20] {
   reserve_player_ref(|p|{
    let s=p.movie.score.get_sprite(n).unwrap();
    let refs=s.script_instance_list.iter().map(|r|p.allocator.get_script_instance(r).script.cast_member).collect::<Vec<_>>();
    assert_eq!(refs,vec![27],"channel{n} must acquire authored board drag behavior");
    assert!(s.puppet);assert!(!s.visible);assert!(s.moveable);assert_eq!(s.blend,37);assert_eq!(s.loc_h,123+i32::from(n));assert_eq!(s.loc_v,234);
    assert!(s.entered&&!s.exited);
    assert!(!p.script_instance_list_cache.contains_key(&n),"old public behavior cache cleared");
   });
  }
  println!("PASS: K01 puppet channels18/20 keep appearance, replace script66 with27, clear old list cache");
 });
}
