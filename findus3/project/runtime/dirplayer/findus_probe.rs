//! Local compatibility probe: interprets Director bytecode, never executes the original EXE.
use vm_rust::player::testing::{run_test, TestPlayer, StageSnapshot};
use vm_rust::player::testing_shared::TestHarness;
fn main() {
    let args: Vec<String> = std::env::args().collect();
    assert!(args.len() >= 3, "findus_probe movie.dxr screenshot.png [frames]");
    let frames:usize=args.get(3).and_then(|s|s.parse().ok()).unwrap_or(40);
    run_test(async {
        let mut player = TestPlayer::new();
        player.load_movie(&args[1]).await;
        player.init_movie().await;
        player.step_frames(frames).await;
        let shot=StageSnapshot::from_output(player.snapshot_stage());
        std::fs::write(&args[2],shot.to_png()).unwrap();
        println!("PROBE {{\"frame\":{},\"is_playing\":{},\"width\":{},\"height\":{}}}",player.current_frame(),player.is_playing(),shot.width,shot.height);
    });
}
