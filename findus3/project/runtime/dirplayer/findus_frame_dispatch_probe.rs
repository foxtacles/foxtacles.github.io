//! Regression for duplicate exitFrame delivery after Director 7 forward go().
//!
//! Use DAG13's actual frame 12 initialization/go(#next), but count frame 13's
//! exitFrame instead of executing its random-deck loop. A regression then fails
//! a finite assertion rather than spinning forever with all eight cards used.
use std::{cell::Cell, rc::Rc};

use vm_rust::player::{
    cast_lib::cast_member_ref,
    datum_ref::DatumRef,
    reserve_player_mut, reserve_player_ref,
    script_ref::ScriptInstanceRef,
    symbols::{builtin::BuiltInSymbol, symbol::Symbol},
    testing::{run_test, TestPlayer},
    testing_shared::TestHarness,
    virtual_scripts::{VirtualScriptHandler, VirtualScriptRegistry},
    DirPlayer, ScriptError,
};

struct CountFrameExit(Rc<Cell<usize>>);

impl VirtualScriptHandler for CountFrameExit {
    fn has_handler(&self, name: Symbol) -> bool {
        name.eq_builtin(BuiltInSymbol::ExitFrame)
    }

    fn call_handler(
        &self, _player: &mut DirPlayer, _instance: Option<&ScriptInstanceRef>,
        name: Symbol, _args: &Vec<DatumRef>,
    ) -> Result<Option<DatumRef>, ScriptError> {
        if name.eq_builtin(BuiltInSymbol::ExitFrame) {
            self.0.set(self.0.get() + 1);
            Ok(Some(DatumRef::Void))
        } else {
            Ok(None)
        }
    }
}

fn main() {
    let movie = std::env::args().nth(1)
        .expect("findus_frame_dispatch_probe /path/to/DAG13.DXR");
    run_test(async {
        let mut harness = TestPlayer::new();
        harness.load_movie(&movie).await;
        let green_card = harness.eval("member(\"grön3\").number").await
            .expect("resolve original Macintosh cast member name");
        assert_eq!(reserve_player_ref(|p| p.get_datum(&green_card).int_value().unwrap()), 38);
        let exits = Rc::new(Cell::new(0));
        reserve_player_mut(|player| {
            VirtualScriptRegistry::attach(
                player, cast_member_ref(1, 2), Rc::new(CountFrameExit(exits.clone())),
            );
        });
        harness.eval("go(12)").await.expect("enter original memory initialization");
        harness.step_frame().await;
        assert_eq!(reserve_player_ref(|p| p.movie.current_frame), 13);
        assert_eq!(exits.get(), 0, "destination frame must not receive a second exitFrame in the departing frame's dispatch");
        harness.step_frame().await;
        assert_eq!(exits.get(), 1, "memory frame must receive exitFrame exactly once");
        assert_eq!(reserve_player_ref(|p| p.movie.current_frame), 14);
        println!("FRAME_DISPATCH DAG13: frame12 -> frame13 -> frame14, memory initialization called once");
        println!("MAC_MEMBER DAG13: member(\"grön3\").number = 38");
    });
}
