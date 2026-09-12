//! Inspect original Director score/casts without running Lingo or sound.
//! Usage: findus_render_probe movie.dxr output-directory [frame]
use vm_rust::player::{reserve_player_mut, reserve_player_ref};
use vm_rust::player::cast_member::CastMemberType;
use vm_rust::player::score::ScoreRef;
use vm_rust::player::testing::{run_test, TestPlayer, StageSnapshot};
use vm_rust::player::testing_shared::TestHarness;
use serde_json::json;

fn main() {
    let args: Vec<String> = std::env::args().collect();
    assert!(args.len() >= 3, "findus_render_probe movie.dxr output-directory [frame]");
    let frame: u32 = args.get(3).and_then(|v| v.parse().ok()).unwrap_or(5);
    let output = std::path::Path::new(&args[2]);
    std::fs::create_dir_all(output).unwrap();
    run_test(async {
        let mut harness = TestPlayer::new();
        harness.load_movie(&args[1]).await;
        let initial = reserve_player_ref(|p| {
            let palettes = p.movie.cast_manager.palettes();
            let casts: Vec<_> = p.movie.cast_manager.casts.iter().map(|cast| {
                let mut members = Vec::new();
                for member in cast.members.values() {
                    if let CastMemberType::Bitmap(bm) = &member.member_type {
                        if let Some(bitmap) = p.bitmap_manager.get_bitmap(bm.image_ref) {
                            let mut pixels = Vec::with_capacity(bitmap.width as usize * bitmap.height as usize * 3);
                            for y in 0..bitmap.height { for x in 0..bitmap.width {
                                let (r,g,b) = bitmap.get_pixel_color(&palettes, x, y);
                                pixels.extend_from_slice(&[r,g,b]);
                            }}
                            let path = format!("cast-{}-member-{}.png", cast.number, member.number);
                            if bitmap.width > 0 && bitmap.height > 0 {
                                image::save_buffer(output.join(&path), &pixels, bitmap.width as u32, bitmap.height as u32, image::ColorType::Rgb8).unwrap();
                            }
                            members.push(json!({"member": member.number, "name":member.name, "width":bitmap.width,"height":bitmap.height,"depth":bitmap.original_bit_depth,"palette":format!("{:?}",bitmap.palette_ref),"alpha":bitmap.use_alpha,"path":path}));
                        }
                    }
                }
                json!({"cast":cast.number,"name":cast.name,"external":cast.is_external,"state":format!("{:?}",cast.state),"file":cast.file_name,"members":members})
            }).collect();
            let score: Vec<_> = p.movie.score.channel_initialization_data.iter().filter(|(f,_,_)|*f+1==frame).map(|(f,ch,d)|json!({"frame":f+1,"channel_index":ch,"cast":d.cast_lib,"member":d.cast_member,"x":d.pos_x,"y":d.pos_y,"width":d.width,"height":d.height,"blend":d.blend,"flags":d.sprite_flags})).collect();
            let spans:Vec<_>=p.movie.score.sprite_spans.iter().filter(|s|s.start_frame<=frame&&s.end_frame>=frame).map(|s|json!({"channel":s.channel_number,"start":s.start_frame,"end":s.end_frame})).collect();
            json!({"frame":frame,"casts":casts,"score":score,"spans":spans})
        });
        std::fs::write(output.join("loaded.json"),serde_json::to_vec_pretty(&initial).unwrap()).unwrap();
        if reserve_player_ref(|p| p.movie.score.channel_initialization_data.is_empty()) {
            println!("exported cast assets (no authored score)");
            return;
        }
        reserve_player_mut(|p| {
            p.movie.current_frame=frame;
            p.movie.score.sound_channel_data.clear();
            p.movie.score.sprite_details.clear();
            for span in &mut p.movie.score.sprite_spans { span.scripts.clear(); }
        });
        // begin_sprites internally accesses the same globally owned player,
        // matching the runtime's call pattern. No script events are dispatched.
        unsafe { vm_rust::player::player_mut().movie.score.begin_sprites(ScoreRef::Stage,frame); }
        let sprites=reserve_player_ref(|p|p.movie.score.channels.iter().filter(|ch|ch.sprite.member.is_some()).map(|ch|{let s=&ch.sprite;json!({"channel":ch.number,"member":format!("{:?}",s.member),"x":s.loc_h,"y":s.loc_v,"width":s.width,"height":s.height,"blend":s.blend,"ink":s.ink,"visible":s.visible,"entered":s.entered})}).collect::<Vec<_>>());
        std::fs::write(output.join("sprites.json"),serde_json::to_vec_pretty(&sprites).unwrap()).unwrap();
        let shot=StageSnapshot::from_output(harness.snapshot_stage());
        std::fs::write(output.join("stage.png"),shot.to_png()).unwrap();
        println!("rendered authored frame {} (Lingo/sound intentionally skipped)",frame);
    });
}
