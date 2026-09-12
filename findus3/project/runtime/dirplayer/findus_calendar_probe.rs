//! Execute the original KALENDER checkDate bytecode against controlled local dates.
use vm_rust::player::testing::{run_test, TestPlayer};
use vm_rust::player::testing_shared::TestHarness;
use vm_rust::player::{reserve_player_mut, reserve_player_ref};
use vm_rust::player::symbols::symbol::Symbol;

fn main() {
    let movie = std::env::args().nth(1).expect("findus_calendar_probe /path/to/KALENDER.DXR");
    run_test(async {
        let mut harness = TestPlayer::new();
        harness.load_movie(&movie).await;
        // Invoking only this handler avoids score/input/audio dependencies. It
        // is the actual compiled calendar policy, not a copy in the test.
        for (date, unlocked) in [
            ("2026-08-31", 25), ("2026-09-01", 1), ("2026-11-30", 1),
            ("2026-12-01", 1), ("2026-12-16", 16), ("2026-12-24", 24),
            ("2026-12-25", 25), ("2027-01-01", 25), ("2028-02-29", 25),
        ] {
            reserve_player_mut(|p| { p.external_params.insert("findusDate".into(), date.into()); });
            harness.eval("checkDate()").await.expect("checkDate bytecode failed");
            let actual = reserve_player_ref(|p| p.get_datum(p.globals.get(&Symbol::from_str("decDate")).expect("checkDate did not set decDate")).int_value().unwrap());
            assert_eq!(actual, unlocked, "{date}");
            println!("CALENDAR {date}: decDate={unlocked}");
        }
    });
}
