//! Original-file regression: changing movies must reset the entire stage.
//! Usage: findus_transition_probe KALENDER.DXR DAG01.DXR output-directory
use vm_rust::player::{reserve_player_mut, reserve_player_ref};
use vm_rust::player::score::{ScoreRef, ScoreSpriteSpan};
use vm_rust::player::sprite::ColorRef;
use vm_rust::player::testing::{run_test, TestPlayer, StageSnapshot};
use vm_rust::player::testing_shared::TestHarness;
use serde_json::json;

fn prepare_stage() {
    reserve_player_mut(|p| {
        p.movie.current_frame=6;
        p.movie.score.sound_channel_data.clear();
        p.movie.score.sprite_details.clear();
        for span in &mut p.movie.score.sprite_spans { span.scripts.clear(); }
    });
    unsafe {vm_rust::player::player_mut().movie.score.begin_sprites(ScoreRef::Stage,6);}
}
fn main() {
    let args:Vec<String>=std::env::args().collect();
    assert_eq!(args.len(),4,"KALENDER.DXR DAG01.DXR output-directory");
    let output=std::path::Path::new(&args[3]);std::fs::create_dir_all(output).unwrap();
    run_test(async {
        let mut harness=TestPlayer::new();
        harness.load_movie(&args[2]).await;
        prepare_stage();
        let fresh=StageSnapshot::from_output(harness.snapshot_stage());
        let fresh_png=fresh.to_png();
        std::fs::write(output.join("fresh.png"),&fresh_png).unwrap();
        harness.load_movie(&args[1]).await;
        reserve_player_mut(|p| {
            let score=&mut p.movie.score;
            score.set_channel_count(300);
            for channel in &mut score.channels {
                let s=&mut channel.sprite;
                s.visible=false;s.puppet=true;s.moveable=true;s.trails=true;
                s.ink=36;s.blend=13;s.rotation=33.0;s.skew=19.0;
                s.flip_h=true;s.flip_v=true;s.constraint=299;s.editable=true;
                s.loc_h=999;s.loc_v=777;s.loc_z=-123;s.width=17;s.height=29;
                s.color=ColorRef::Rgb(3,7,11);s.bg_color=ColorRef::Rgb(251,211,191);
                s.name="OLD_MOVIE".into();s.entered=true;s.exited=true;
                s.has_visible_mod=true;s.pending_unpuppet_revert=true;
            }
            score.sprite_spans.push(ScoreSpriteSpan{channel_number:299,start_frame:1,end_frame:999,scripts:vec![]});
            score.sound_channel_triggered.insert(1,999);
            score.last_sound_clear_frame=Some(999);
            score.active_channels_cache.borrow_mut().insert(6,vec![299]);
            score.invalidate_render_channel_cache();
        });
        harness.load_movie(&args[2]).await;
        reserve_player_ref(|p| {
            for channel in &p.movie.score.channels {
                let s=&channel.sprite;
                assert!(s.visible,"channel{} retained visibility",channel.number);
                assert!(!s.puppet&&!s.moveable&&!s.trails,"channel{} retained puppet/drag/trails",channel.number);
                assert_eq!(s.rotation,0.0);assert_eq!(s.skew,0.0);
                assert!(!s.flip_h&&!s.flip_v&&!s.editable);
                assert_eq!(s.constraint,0);assert_eq!(s.loc_z,channel.number as i32);
                assert_ne!(s.name,"OLD_MOVIE");assert!(!s.has_visible_mod);
                assert!(!s.pending_unpuppet_revert);
            }
            assert!(!p.movie.score.sprite_spans.iter().any(|span|span.channel_number==299));
            assert_ne!(p.movie.score.last_sound_clear_frame,Some(999));
            assert!(!p.movie.score.sound_channel_triggered.values().any(|&v|v==999));
        });
        prepare_stage();
        let transitioned=StageSnapshot::from_output(harness.snapshot_stage());
        let transitioned_png=transitioned.to_png();
        std::fs::write(output.join("after-transition.png"),&transitioned_png).unwrap();
        assert_eq!(fresh_png,transitioned_png,"stage pixels differ after cross-movie contamination");
        std::fs::write(output.join("result.json"),serde_json::to_vec_pretty(&json!({"passed":true,"movies":[args[1],args[2]],"stage_png_bytes_equal":true,"contamination":"visibility, puppet, moveable, trails, ink, blend, dimensions, transforms, constraints, color, channel names, span/cache/sound-trigger state"})).unwrap()).unwrap();
        println!("PASS: new-movie stage clears prior channel state; DAG01 pixels equal fresh load");
    });
}
