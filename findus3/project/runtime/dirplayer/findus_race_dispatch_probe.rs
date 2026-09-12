//! Regression: a dead Director cast-member reference must not alias an Lctx ID.
use vm_rust::player::{
    cast_lib::cast_member_ref, reserve_player_ref,
    testing::{run_test, TestPlayer}, testing_shared::TestHarness,
};
fn main() {
    let movie = std::env::args().nth(1).expect("findus_race_dispatch_probe /path/to/DAG01.DXR");
    run_test(async {
        let mut harness = TestPlayer::new();
        harness.load_movie(&movie).await;
        reserve_player_ref(|p| {
            assert!(p.movie.cast_manager.get_script_by_ref(&cast_member_ref(1, 22)).is_none(),
                "dead cast member 22 must not resolve live member 27 via Lctx ID 22");
            let rooster = p.movie.cast_manager.get_script_by_ref(&cast_member_ref(1, 27)).unwrap();
            assert_eq!(rooster.member_ref.cast_member, 27);
            assert_eq!(p.movie.score.get_script_in_frame(15).unwrap().cast_member, 3);
        });
        harness.eval("go(5)").await.expect("enter checkpoint initialization");
        harness.step_frame().await;
        harness.eval("go(10)").await.expect("create car through original initializer");
        harness.step_frame().await;
        harness.eval("go(14)").await.expect("enter original race initialization");
        harness.step_frame().await;
        for _ in 0..3 {
            async_std::future::timeout(std::time::Duration::from_millis(300), harness.step_frame())
                .await.expect("race frame must return, without unrelated narration busy loop");
            reserve_player_ref(|p| {
                assert_eq!(p.movie.current_frame, 15);
                assert_eq!(p.scope_count, 0);
                assert_eq!(p.handler_stack_depth, 0);
            });
        }
        assert!(reserve_player_ref(|p| p.get_hydrated_globals().get(&vm_rust::player::symbols::symbol::Symbol::from_str("gGameTime")).unwrap().int_value().unwrap()) >= 0,
            "original drive exitFrame must update gGameTime from initial -1");
        println!("RACE_DISPATCH: dead member22 stays absent; frame15 driving exitFrame completes three times");
    });
}
