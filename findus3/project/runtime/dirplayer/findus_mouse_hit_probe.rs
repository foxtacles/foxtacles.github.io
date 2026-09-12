//! Original DAG06's backdrop has a non-interactive helper script attached.
//! It must not intercept the difficulty buttons below it.
use vm_rust::player::{testing::{TestPlayer,run_test},testing_shared::TestHarness,reserve_player_ref,
    score::{get_concrete_sprite_rect,get_sprite_at,get_mouse_sprite_at}};
fn main(){
    let movie=std::env::args().nth(1).expect("DAG06.DXR path");
    run_test(async{
        let mut h=TestPlayer::new();h.load_movie(&movie).await;h.init_movie().await;
        h.eval("go(11)").await.unwrap();
        // The authored rollover shows these highlights before the press.
        h.eval("sprite(17).visible=TRUE").await.unwrap();
        h.eval("sprite(18).visible=TRUE").await.unwrap();
        reserve_player_ref(|p|{
            for channel in [17,18]{
                let rect=get_concrete_sprite_rect(p,p.movie.score.get_sprite(channel).unwrap());
                let (x,y)=((rect.left+rect.right)/2,(rect.top+rect.bottom)/2);
                assert_eq!(get_sprite_at(p,x,y,true),Some(25),"fixture must contain the original helper-script backdrop");
                assert_eq!(get_mouse_sprite_at(p,x,y),Some(channel as u32),"mouse input must reach its difficulty button");
            }
        });
        println!("DAG06 both original difficulty buttons receive mouse input through the helper backdrop");
    });
}
