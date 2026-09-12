/* @ts-self-types="./vm_rust.d.ts" */
import { createExternalXtraInstance, dispatchExternalXtraInstanceHandler, dispatchExternalXtraStaticHandler, externalXtraHasStaticHandler, onBreakpointListChanged, onCastLibNameChanged, onCastMemberListChanged, onChannelDisplayNameChanged, onClearTimeout, onDatumSnapshot, onDebugMessage, onExternalEvent, onFlashMemberLoaded, onFrameChanged, onMovieLoadFailed, onMovieLoaded, onRequestXtraLoad, onScheduleTimeout, onScopeListChanged, onScriptInstanceSnapshot, onStageSizeChanged } from 'dirplayer-js-api';

export class JsBridgeBreakpoint {
    __destroy_into_raw() {
        const ptr = this.__wbg_ptr;
        this.__wbg_ptr = 0;
        JsBridgeBreakpointFinalization.unregister(this);
        return ptr;
    }
    free() {
        const ptr = this.__destroy_into_raw();
        wasm.__wbg_jsbridgebreakpoint_free(ptr, 0);
    }
    /**
     * @returns {number}
     */
    get bytecode_index() {
        const ret = wasm.__wbg_get_jsbridgebreakpoint_bytecode_index(this.__wbg_ptr);
        return ret >>> 0;
    }
    /**
     * @returns {string}
     */
    get handler_name() {
        let deferred1_0;
        let deferred1_1;
        try {
            const ret = wasm.__wbg_get_jsbridgebreakpoint_handler_name(this.__wbg_ptr);
            deferred1_0 = ret[0];
            deferred1_1 = ret[1];
            return getStringFromWasm0(ret[0], ret[1]);
        } finally {
            wasm.__wbindgen_free(deferred1_0, deferred1_1, 1);
        }
    }
    /**
     * @returns {string}
     */
    get script_name() {
        let deferred1_0;
        let deferred1_1;
        try {
            const ret = wasm.__wbg_get_jsbridgebreakpoint_script_name(this.__wbg_ptr);
            deferred1_0 = ret[0];
            deferred1_1 = ret[1];
            return getStringFromWasm0(ret[0], ret[1]);
        } finally {
            wasm.__wbindgen_free(deferred1_0, deferred1_1, 1);
        }
    }
    /**
     * @param {number} arg0
     */
    set bytecode_index(arg0) {
        wasm.__wbg_set_jsbridgebreakpoint_bytecode_index(this.__wbg_ptr, arg0);
    }
    /**
     * @param {string} arg0
     */
    set handler_name(arg0) {
        const ptr0 = passStringToWasm0(arg0, wasm.__wbindgen_malloc, wasm.__wbindgen_realloc);
        const len0 = WASM_VECTOR_LEN;
        wasm.__wbg_set_jsbridgebreakpoint_handler_name(this.__wbg_ptr, ptr0, len0);
    }
    /**
     * @param {string} arg0
     */
    set script_name(arg0) {
        const ptr0 = passStringToWasm0(arg0, wasm.__wbindgen_malloc, wasm.__wbindgen_realloc);
        const len0 = WASM_VECTOR_LEN;
        wasm.__wbg_set_jsbridgebreakpoint_script_name(this.__wbg_ptr, ptr0, len0);
    }
}
if (Symbol.dispose) JsBridgeBreakpoint.prototype[Symbol.dispose] = JsBridgeBreakpoint.prototype.free;

export class OnMovieLoadedCallbackData {
    static __wrap(ptr) {
        ptr = ptr >>> 0;
        const obj = Object.create(OnMovieLoadedCallbackData.prototype);
        obj.__wbg_ptr = ptr;
        OnMovieLoadedCallbackDataFinalization.register(obj, obj.__wbg_ptr, obj);
        return obj;
    }
    __destroy_into_raw() {
        const ptr = this.__wbg_ptr;
        this.__wbg_ptr = 0;
        OnMovieLoadedCallbackDataFinalization.unregister(this);
        return ptr;
    }
    free() {
        const ptr = this.__destroy_into_raw();
        wasm.__wbg_onmovieloadedcallbackdata_free(ptr, 0);
    }
    /**
     * @returns {string}
     */
    get test_val() {
        let deferred1_0;
        let deferred1_1;
        try {
            const ret = wasm.__wbg_get_onmovieloadedcallbackdata_test_val(this.__wbg_ptr);
            deferred1_0 = ret[0];
            deferred1_1 = ret[1];
            return getStringFromWasm0(ret[0], ret[1]);
        } finally {
            wasm.__wbindgen_free(deferred1_0, deferred1_1, 1);
        }
    }
    /**
     * @returns {number}
     */
    get version() {
        const ret = wasm.__wbg_get_onmovieloadedcallbackdata_version(this.__wbg_ptr);
        return ret;
    }
    /**
     * @param {string} arg0
     */
    set test_val(arg0) {
        const ptr0 = passStringToWasm0(arg0, wasm.__wbindgen_malloc, wasm.__wbindgen_realloc);
        const len0 = WASM_VECTOR_LEN;
        wasm.__wbg_set_jsbridgebreakpoint_script_name(this.__wbg_ptr, ptr0, len0);
    }
    /**
     * @param {number} arg0
     */
    set version(arg0) {
        wasm.__wbg_set_onmovieloadedcallbackdata_version(this.__wbg_ptr, arg0);
    }
}
if (Symbol.dispose) OnMovieLoadedCallbackData.prototype[Symbol.dispose] = OnMovieLoadedCallbackData.prototype.free;

export class OnScriptErrorCallbackData {
    __destroy_into_raw() {
        const ptr = this.__wbg_ptr;
        this.__wbg_ptr = 0;
        OnScriptErrorCallbackDataFinalization.unregister(this);
        return ptr;
    }
    free() {
        const ptr = this.__destroy_into_raw();
        wasm.__wbg_onscripterrorcallbackdata_free(ptr, 0);
    }
    /**
     * @returns {string | undefined}
     */
    get handler_name() {
        const ret = wasm.__wbg_get_onscripterrorcallbackdata_handler_name(this.__wbg_ptr);
        let v1;
        if (ret[0] !== 0) {
            v1 = getStringFromWasm0(ret[0], ret[1]).slice();
            wasm.__wbindgen_free(ret[0], ret[1] * 1, 1);
        }
        return v1;
    }
    /**
     * @returns {boolean}
     */
    get is_paused() {
        const ret = wasm.__wbg_get_onscripterrorcallbackdata_is_paused(this.__wbg_ptr);
        return ret !== 0;
    }
    /**
     * @returns {string}
     */
    get message() {
        let deferred1_0;
        let deferred1_1;
        try {
            const ret = wasm.__wbg_get_onscripterrorcallbackdata_message(this.__wbg_ptr);
            deferred1_0 = ret[0];
            deferred1_1 = ret[1];
            return getStringFromWasm0(ret[0], ret[1]);
        } finally {
            wasm.__wbindgen_free(deferred1_0, deferred1_1, 1);
        }
    }
    /**
     * @returns {Int32Array | undefined}
     */
    get script_member_ref() {
        const ret = wasm.__wbg_get_onscripterrorcallbackdata_script_member_ref(this.__wbg_ptr);
        let v1;
        if (ret[0] !== 0) {
            v1 = getArrayI32FromWasm0(ret[0], ret[1]).slice();
            wasm.__wbindgen_free(ret[0], ret[1] * 4, 4);
        }
        return v1;
    }
    /**
     * @param {string | null} [arg0]
     */
    set handler_name(arg0) {
        var ptr0 = isLikeNone(arg0) ? 0 : passStringToWasm0(arg0, wasm.__wbindgen_malloc, wasm.__wbindgen_realloc);
        var len0 = WASM_VECTOR_LEN;
        wasm.__wbg_set_onscripterrorcallbackdata_handler_name(this.__wbg_ptr, ptr0, len0);
    }
    /**
     * @param {boolean} arg0
     */
    set is_paused(arg0) {
        wasm.__wbg_set_onscripterrorcallbackdata_is_paused(this.__wbg_ptr, arg0);
    }
    /**
     * @param {string} arg0
     */
    set message(arg0) {
        const ptr0 = passStringToWasm0(arg0, wasm.__wbindgen_malloc, wasm.__wbindgen_realloc);
        const len0 = WASM_VECTOR_LEN;
        wasm.__wbg_set_jsbridgebreakpoint_script_name(this.__wbg_ptr, ptr0, len0);
    }
    /**
     * @param {Int32Array | null} [arg0]
     */
    set script_member_ref(arg0) {
        var ptr0 = isLikeNone(arg0) ? 0 : passArray32ToWasm0(arg0, wasm.__wbindgen_malloc);
        var len0 = WASM_VECTOR_LEN;
        wasm.__wbg_set_onscripterrorcallbackdata_script_member_ref(this.__wbg_ptr, ptr0, len0);
    }
}
if (Symbol.dispose) OnScriptErrorCallbackData.prototype[Symbol.dispose] = OnScriptErrorCallbackData.prototype.free;

export class WebAudioBackend {
    __destroy_into_raw() {
        const ptr = this.__wbg_ptr;
        this.__wbg_ptr = 0;
        WebAudioBackendFinalization.unregister(this);
        return ptr;
    }
    free() {
        const ptr = this.__destroy_into_raw();
        wasm.__wbg_webaudiobackend_free(ptr, 0);
    }
    constructor() {
        const ret = wasm.webaudiobackend_new();
        if (ret[2]) {
            throw takeFromExternrefTable0(ret[1]);
        }
        this.__wbg_ptr = ret[0] >>> 0;
        WebAudioBackendFinalization.register(this, this.__wbg_ptr, this);
        return this;
    }
    resume_context() {
        const ret = wasm.webaudiobackend_resume_context(this.__wbg_ptr);
        if (ret[1]) {
            throw takeFromExternrefTable0(ret[0]);
        }
    }
    resume_sound() {
        wasm.webaudiobackend_resume_sound(this.__wbg_ptr);
    }
}
if (Symbol.dispose) WebAudioBackend.prototype[Symbol.dispose] = WebAudioBackend.prototype.free;

/**
 * @param {string} script_name
 * @param {string} handler_name
 * @param {number} bytecode_index
 */
export function add_breakpoint(script_name, handler_name, bytecode_index) {
    const ptr0 = passStringToWasm0(script_name, wasm.__wbindgen_malloc, wasm.__wbindgen_realloc);
    const len0 = WASM_VECTOR_LEN;
    const ptr1 = passStringToWasm0(handler_name, wasm.__wbindgen_malloc, wasm.__wbindgen_realloc);
    const len1 = WASM_VECTOR_LEN;
    wasm.add_breakpoint(ptr0, len0, ptr1, len1, bytecode_index);
}

/**
 * @returns {string}
 */
export function bench_bytecode_throughput() {
    let deferred1_0;
    let deferred1_1;
    try {
        const ret = wasm.bench_bytecode_throughput();
        deferred1_0 = ret[0];
        deferred1_1 = ret[1];
        return getStringFromWasm0(ret[0], ret[1]);
    } finally {
        wasm.__wbindgen_free(deferred1_0, deferred1_1, 1);
    }
}

export function clear_debug_messages() {
    wasm.clear_debug_messages();
}

/**
 * Clear the font cache so fonts will be re-rasterized on next use.
 * Call this after set_glyph_preference("outline") to see the effect.
 */
export function clear_font_cache() {
    wasm.clear_font_cache();
}

/**
 * Discard all buffered profiling events.
 */
export function clear_profiling_recording() {
    wasm.clear_profiling_recording();
}

/**
 * Signal completion of an on-demand xtra load. Called by JS after it
 * resolves `name` through the registry and either successfully loads
 * the plugin (`success = true`) or fails / can't find a matching URL
 * (`success = false`). Wakes every Lingo handler that's awaiting
 * `request_xtra_load(name)`; the bytecode dispatcher then retries the
 * lookup with the now-registered xtra.
 *
 * Idempotent; calling with an unknown name or after the waiters have
 * already been drained is a no-op.
 * @param {string} name
 * @param {boolean} success
 */
export function complete_external_xtra_load(name, success) {
    const ptr0 = passStringToWasm0(name, wasm.__wbindgen_malloc, wasm.__wbindgen_realloc);
    const len0 = WASM_VECTOR_LEN;
    wasm.complete_external_xtra_load(ptr0, len0, success);
}

/**
 * Delete the current selection in the focused editable member. Used by cut.
 */
export function delete_focused_field_selection() {
    wasm.delete_focused_field_selection();
}

/**
 * Datum-arena census: live count per datum type, plus Int pool/refcount
 * detail. Callable from the console as `dirplayer_datumStats()` while a movie
 * is running, so a long Lingo loop that is growing the heap can be attributed
 * to what it is actually allocating instead of guessed at from a CPU profile.
 * @returns {string}
 */
export function dirplayer_datumStats() {
    let deferred1_0;
    let deferred1_1;
    try {
        const ret = wasm.dirplayer_datumStats();
        deferred1_0 = ret[0];
        deferred1_1 = ret[1];
        return getStringFromWasm0(ret[0], ret[1]);
    } finally {
        wasm.__wbindgen_free(deferred1_0, deferred1_1, 1);
    }
}

/**
 * Dispatch a Flash `getURL("event: …")` body into Director's event chain.
 *
 * Called from the JS Flash bridge whenever a SWF tries to navigate to a
 * `event:`-scheme URL — Director's Flash Asset Xtra convention for sending a
 * Lingo message back to the host movie.
 *
 * The first whitespace-delimited token is the handler name. The remainder is
 * the argument list, which Director's Flash Asset Xtra spells as a normal
 * Lingo argument list — comma-separated literals. age_of_speed's off-game SWF
 * builds `event:flash_start "1","1","0","1","1","0","1"` for
 * `on flash_start me, fRaceId, fAmbientationId, …`; splitting that on
 * whitespace yielded ONE String argument and left every real parameter VOID
 * (`member(179 + gLevelID)` then resolved to an empty slot).
 *
 * Quoting is significant and must be preserved: a quoted `"1"` stays a
 * String, because these scripts compare against string literals
 * (`if fGenericHelp = "1"`, `if fAudioState = "0"`) — coercing it to Int
 * would silently break those tests.
 *
 * Bodies with no comma keep the older whitespace tokenisation, so `send #done`
 * still invokes `on send` with `#done` as its first arg — `send` is not a
 * keyword, it's just the most common handler name games define for routing to
 * sendSprite / sendAllSprites (e.g. storyscramble's BehaviorScript 24).
 *
 * `cast_lib` / `cast_member` identify the Flash member that fired the
 * navigation, so a future revision can target the host sprite first; for now
 * the dispatch is global via `player_invoke_global_event`.
 *
 * Returns true when the body was understood and queued, false when the form
 * is unrecognised (caller may then fall through to a real navigation).
 * @param {number} cast_lib
 * @param {number} cast_member
 * @param {string} body
 * @returns {boolean}
 */
export function dispatch_flash_event(cast_lib, cast_member, body) {
    const ptr0 = passStringToWasm0(body, wasm.__wbindgen_malloc, wasm.__wbindgen_realloc);
    const len0 = WASM_VECTOR_LEN;
    const ret = wasm.dispatch_flash_event(cast_lib, cast_member, ptr0, len0);
    return ret !== 0;
}

/**
 * Execute a `getURL("lingo: …")` navigation body from a Flash SWF as a
 * Lingo command, matching Director's Flash Asset Xtra convention.
 *
 * Director's Flash sprite interprets a `getURL` whose URL begins with the
 * `lingo:` scheme by evaluating the remainder as a Lingo command in the
 * movie's global handler context — exactly like `do "…"`. Pengapop's
 * titleScreen SWF uses this for every button: the Play button navigates to
 * `lingo:startGameTimed`, the hover/click sounds to
 * `lingo:bdPlaySound(#generalSound,"tink")`, etc.
 *
 * The body is everything after the `lingo:` scheme; we run it through the
 * same `eval_lingo_command` path the debugger console and `do` use, so it
 * supports bare handler calls (`startGameTimed`) and calls with args
 * (`bdPlaySound(#generalSound,"tink")`). Returns true so the JS caller can
 * swallow the navigation (nothing should actually open a URL).
 * @param {string} body
 * @returns {boolean}
 */
export function dispatch_flash_lingo(body) {
    const ptr0 = passStringToWasm0(body, wasm.__wbindgen_malloc, wasm.__wbindgen_realloc);
    const len0 = WASM_VECTOR_LEN;
    const ret = wasm.dispatch_flash_lingo(ptr0, len0);
    return ret !== 0;
}

/**
 * @param {string} command
 */
export function eval_command(command) {
    const ptr0 = passStringToWasm0(command, wasm.__wbindgen_malloc, wasm.__wbindgen_realloc);
    const len0 = WASM_VECTOR_LEN;
    wasm.eval_command(ptr0, len0);
}

/**
 * @param {number} cast_lib
 * @param {number} cast_member
 */
export function exportW3dObj(cast_lib, cast_member) {
    wasm.exportW3dObj(cast_lib, cast_member);
}

/**
 * Download raw W3D/IFX data for external testing
 * @param {number} cast_lib
 * @param {number} cast_member
 */
export function exportW3dRaw(cast_lib, cast_member) {
    wasm.exportW3dRaw(cast_lib, cast_member);
}

/**
 * Serialise the recorded events to a speedscope "evented" profile JSON string,
 * ready to be saved as a `.speedscope.json` file and opened in speedscope.
 * @returns {string}
 */
export function export_profiling_speedscope() {
    let deferred1_0;
    let deferred1_1;
    try {
        const ret = wasm.export_profiling_speedscope();
        deferred1_0 = ret[0];
        deferred1_1 = ret[1];
        return getStringFromWasm0(ret[0], ret[1]);
    } finally {
        wasm.__wbindgen_free(deferred1_0, deferred1_1, 1);
    }
}

/**
 * Single-entry dispatcher for every `dx_host_call` a plugin makes. The
 * JS-side plugin import for `dirplayer_xtra_host::dx_host_call` reads
 * the args from plugin memory, passes them here, and writes the
 * returned bytes back into plugin memory. Returning an empty `Vec` is
 * the "void" sentinel for fire-and-forget ops like `log`.
 * @param {number} op_id
 * @param {Uint8Array} args
 * @returns {Uint8Array}
 */
export function external_xtra_host_dispatch(op_id, args) {
    const ptr0 = passArray8ToWasm0(args, wasm.__wbindgen_malloc);
    const len0 = WASM_VECTOR_LEN;
    const ret = wasm.external_xtra_host_dispatch(op_id, ptr0, len0);
    var v2 = getArrayU8FromWasm0(ret[0], ret[1]).slice();
    wasm.__wbindgen_free(ret[0], ret[1] * 1, 1);
    return v2;
}

/**
 * Continuation of a click-drag in an editable Field/Text — extends sel_end
 * to the position under the current pointer, sel_anchor unchanged.
 * @param {number} sprite_id
 * @param {number} canvas_x
 * @param {number} canvas_y
 */
export function field_drag_extend_to(sprite_id, canvas_x, canvas_y) {
    wasm.field_drag_extend_to(sprite_id, canvas_x, canvas_y);
}

/**
 * Select all text in the focused editable member (Cmd/Ctrl+A).
 */
export function field_select_all() {
    wasm.field_select_all();
}

/**
 * Triple-click line selection at the given canvas coordinates.
 * @param {number} sprite_id
 * @param {number} canvas_x
 * @param {number} canvas_y
 */
export function field_select_line_at(sprite_id, canvas_x, canvas_y) {
    wasm.field_select_line_at(sprite_id, canvas_x, canvas_y);
}

/**
 * Double-click word selection at the given canvas coordinates.
 * @param {number} sprite_id
 * @param {number} canvas_x
 * @param {number} canvas_y
 */
export function field_select_word_at(sprite_id, canvas_x, canvas_y) {
    wasm.field_select_word_at(sprite_id, canvas_x, canvas_y);
}

/**
 * Place the caret in an editable Field/Text at the given canvas coordinates.
 * `extend` mirrors a shift-click: extends from the existing anchor instead
 * of collapsing the selection.
 * @param {number} sprite_id
 * @param {number} canvas_x
 * @param {number} canvas_y
 * @param {boolean} extend
 */
export function field_set_caret_at(sprite_id, canvas_x, canvas_y, extend) {
    wasm.field_set_caret_at(sprite_id, canvas_x, canvas_y, extend);
}

/**
 * Read audio state without interrupting an executing Lingo handler.
 * @returns {string}
 */
export function get_audio_state() {
    let deferred1_0;
    let deferred1_1;
    try {
        const ret = wasm.get_audio_state();
        deferred1_0 = ret[0];
        deferred1_1 = ret[1];
        return getStringFromWasm0(ret[0], ret[1]);
    } finally {
        wasm.__wbindgen_free(deferred1_0, deferred1_1, 1);
    }
}

/**
 * @returns {boolean}
 */
export function get_break_on_error() {
    const ret = wasm.get_break_on_error();
    return ret !== 0;
}

/**
 * Read the current breakpoint list.
 *
 * The UI otherwise only ever learns breakpoints from the
 * `onBreakpointListChanged` push, so a view that mounts after the push — or a
 * session where the push never happened — shows none of them. This gives it a
 * way to ask.
 * @returns {Array<any>}
 */
export function get_breakpoints() {
    const ret = wasm.get_breakpoints();
    return ret;
}

/**
 * @param {number} cast_number
 * @returns {any}
 */
export function get_cast_chunk_list(cast_number) {
    const ret = wasm.get_cast_chunk_list(cast_number);
    return ret;
}

/**
 * @param {number} cast_number
 * @param {number} chunk_id
 * @returns {Uint8Array | undefined}
 */
export function get_chunk_bytes(cast_number, chunk_id) {
    const ret = wasm.get_chunk_bytes(cast_number, chunk_id);
    let v1;
    if (ret[0] !== 0) {
        v1 = getArrayU8FromWasm0(ret[0], ret[1]).slice();
        wasm.__wbindgen_free(ret[0], ret[1] * 1, 1);
    }
    return v1;
}

/**
 * Selected text from the focused editable Field/Text. Empty string if no
 * focus, no selection, or non-editable. Synchronous so it can be called
 * from a copy/cut event handler.
 * @returns {string}
 */
export function get_focused_field_selected_text() {
    let deferred1_0;
    let deferred1_1;
    try {
        const ret = wasm.get_focused_field_selected_text();
        deferred1_0 = ret[0];
        deferred1_1 = ret[1];
        return getStringFromWasm0(ret[0], ret[1]);
    } finally {
        wasm.__wbindgen_free(deferred1_0, deferred1_1, 1);
    }
}

/**
 * Get the current glyph rendering preference.
 * @returns {string}
 */
export function get_glyph_preference() {
    let deferred1_0;
    let deferred1_1;
    try {
        const ret = wasm.get_glyph_preference();
        deferred1_0 = ret[0];
        deferred1_1 = ret[1];
        return getStringFromWasm0(ret[0], ret[1]);
    } finally {
        wasm.__wbindgen_free(deferred1_0, deferred1_1, 1);
    }
}

/**
 * @returns {string}
 */
export function get_interp_stats_report() {
    let deferred1_0;
    let deferred1_1;
    try {
        const ret = wasm.get_interp_stats_report();
        deferred1_0 = ret[0];
        deferred1_1 = ret[1];
        return getStringFromWasm0(ret[0], ret[1]);
    } finally {
        wasm.__wbindgen_free(deferred1_0, deferred1_1, 1);
    }
}

/**
 * @returns {any}
 */
export function get_movie_top_level_chunks() {
    const ret = wasm.get_movie_top_level_chunks();
    return ret;
}

/**
 * @param {number} cast_number
 * @param {number} chunk_id
 * @returns {any}
 */
export function get_parsed_chunk(cast_number, chunk_id) {
    const ret = wasm.get_parsed_chunk(cast_number, chunk_id);
    return ret;
}

/**
 * Get whether PFR font rasterization is enabled
 * @returns {boolean}
 */
export function get_pfr_font_enabled() {
    const ret = wasm.get_pfr_font_enabled();
    return ret !== 0;
}

/**
 * Get the current renderer backend name
 * @returns {string}
 */
export function get_renderer_backend() {
    let deferred1_0;
    let deferred1_1;
    try {
        const ret = wasm.get_renderer_backend();
        deferred1_0 = ret[0];
        deferred1_1 = ret[1];
        return getStringFromWasm0(ret[0], ret[1]);
    } finally {
        wasm.__wbindgen_free(deferred1_0, deferred1_1, 1);
    }
}

/**
 * Snapshot the live stage for input replay and compatibility diagnostics.
 * @returns {string}
 */
export function get_stage_snapshot() {
    let deferred1_0;
    let deferred1_1;
    try {
        const ret = wasm.get_stage_snapshot();
        deferred1_0 = ret[0];
        deferred1_1 = ret[1];
        return getStringFromWasm0(ret[0], ret[1]);
    } finally {
        wasm.__wbindgen_free(deferred1_0, deferred1_1, 1);
    }
}

/**
 * Returns the trace log file path and content as a JS object { path, content },
 * or null if no trace log file is set or empty.
 * @returns {any}
 */
export function get_trace_log() {
    const ret = wasm.get_trace_log();
    return ret;
}

/**
 * IME composition committed — `text` is the final string. Same replacement
 * as update, then clears composition state. No-op if no composition is active.
 * @param {string} text
 */
export function ime_composition_end(text) {
    const ptr0 = passStringToWasm0(text, wasm.__wbindgen_malloc, wasm.__wbindgen_realloc);
    const len0 = WASM_VECTOR_LEN;
    wasm.ime_composition_end(ptr0, len0);
}

/**
 * IME composition started — record the byte offset where the provisional
 * composition will begin (= current caret position, with any selection
 * already replaced). No-op if no editable member has focus.
 */
export function ime_composition_start() {
    wasm.ime_composition_start();
}

/**
 * IME composition update — replace the current provisional run with `text`.
 * Caret advances to the end of the new provisional text. No-op if no
 * composition is active.
 * @param {string} text
 */
export function ime_composition_update(text) {
    const ptr0 = passStringToWasm0(text, wasm.__wbindgen_malloc, wasm.__wbindgen_realloc);
    const len0 = WASM_VECTOR_LEN;
    wasm.ime_composition_update(ptr0, len0);
}

/**
 * Whether a Field/Text sprite currently holds keyboard focus. Used by
 * frontend clipboard listeners to decide whether to intercept copy/paste.
 * @returns {boolean}
 */
export function is_field_focused() {
    const ret = wasm.is_field_focused();
    return ret !== 0;
}

/**
 * True while a profiling recording is active.
 * @returns {boolean}
 */
export function is_profiling_recording() {
    const ret = wasm.is_profiling_recording();
    return ret !== 0;
}

/**
 * Check if a sprite is an editable Field or Text member (for mobile keyboard
 * focus and to gate caret/selection events from JS).
 * @param {number} sprite_id
 * @returns {boolean}
 */
export function is_sprite_editable_field(sprite_id) {
    const ret = wasm.is_sprite_editable_field(sprite_id);
    return ret !== 0;
}

/**
 * Check if WebGL2 is supported in the browser
 * @returns {boolean}
 */
export function is_webgl2_supported() {
    const ret = wasm.is_webgl2_supported();
    return ret !== 0;
}

/**
 * @param {string} key
 * @param {number} code
 */
export function key_down(key, code) {
    const ptr0 = passStringToWasm0(key, wasm.__wbindgen_malloc, wasm.__wbindgen_realloc);
    const len0 = WASM_VECTOR_LEN;
    wasm.key_down(ptr0, len0, code);
}

/**
 * @param {string} key
 * @param {number} code
 */
export function key_up(key, code) {
    const ptr0 = passStringToWasm0(key, wasm.__wbindgen_malloc, wasm.__wbindgen_realloc);
    const len0 = WASM_VECTOR_LEN;
    wasm.key_up(ptr0, len0, code);
}

/**
 * List all Shockwave3D members in the movie (for use with exportW3dObj)
 * @returns {string}
 */
export function listW3dMembers() {
    let deferred1_0;
    let deferred1_1;
    try {
        const ret = wasm.listW3dMembers();
        deferred1_0 = ret[0];
        deferred1_1 = ret[1];
        return getStringFromWasm0(ret[0], ret[1]);
    } finally {
        wasm.__wbindgen_free(deferred1_0, deferred1_1, 1);
    }
}

/**
 * @param {string} path
 * @param {boolean} autoplay
 * @returns {Promise<void>}
 */
export function load_movie_file(path, autoplay) {
    const ptr0 = passStringToWasm0(path, wasm.__wbindgen_malloc, wasm.__wbindgen_realloc);
    const len0 = WASM_VECTOR_LEN;
    const ret = wasm.load_movie_file(ptr0, len0, autoplay);
    return ret;
}

/**
 * Flash `LocalConnection.send(connName, method, …args)` forwarded from the
 * Ruffle fork's AVM1 hook. Routes to the Lingo handler a Director-created
 * LocalConnection registered via `setCallback` (connName → lc_path →
 * (handler, target)), dispatched to the exact target instance so `me` is
 * correct. Returns false for a connection dirplayer doesn't own — the caller
 * (fork) has already run Ruffle's normal routing, so a real SWF↔SWF
 * LocalConnection is unaffected. Neopets DGS uses this for the encrypted-score
 * / protocol channel (`send("gObjLC", "createESCORE", score)`).
 * @param {string} connection_name
 * @param {string} method_name
 * @param {string} args_json
 * @returns {boolean}
 */
export function local_connection_send(connection_name, method_name, args_json) {
    const ptr0 = passStringToWasm0(connection_name, wasm.__wbindgen_malloc, wasm.__wbindgen_realloc);
    const len0 = WASM_VECTOR_LEN;
    const ptr1 = passStringToWasm0(method_name, wasm.__wbindgen_malloc, wasm.__wbindgen_realloc);
    const len1 = WASM_VECTOR_LEN;
    const ptr2 = passStringToWasm0(args_json, wasm.__wbindgen_malloc, wasm.__wbindgen_realloc);
    const len2 = WASM_VECTOR_LEN;
    const ret = wasm.local_connection_send(ptr0, len0, ptr1, len1, ptr2, len2);
    return ret !== 0;
}

/**
 * @param {number} cast_lib
 * @param {number} cast_member
 * @param {string} handler_name
 * @returns {string}
 */
export function mcp_decompile_handler(cast_lib, cast_member, handler_name) {
    let deferred2_0;
    let deferred2_1;
    try {
        const ptr0 = passStringToWasm0(handler_name, wasm.__wbindgen_malloc, wasm.__wbindgen_realloc);
        const len0 = WASM_VECTOR_LEN;
        const ret = wasm.mcp_decompile_handler(cast_lib, cast_member, ptr0, len0);
        deferred2_0 = ret[0];
        deferred2_1 = ret[1];
        return getStringFromWasm0(ret[0], ret[1]);
    } finally {
        wasm.__wbindgen_free(deferred2_0, deferred2_1, 1);
    }
}

/**
 * @param {number} cast_lib
 * @param {number} cast_member
 * @param {string} handler_name
 * @returns {string}
 */
export function mcp_disassemble_handler(cast_lib, cast_member, handler_name) {
    let deferred2_0;
    let deferred2_1;
    try {
        const ptr0 = passStringToWasm0(handler_name, wasm.__wbindgen_malloc, wasm.__wbindgen_realloc);
        const len0 = WASM_VECTOR_LEN;
        const ret = wasm.mcp_disassemble_handler(cast_lib, cast_member, ptr0, len0);
        deferred2_0 = ret[0];
        deferred2_1 = ret[1];
        return getStringFromWasm0(ret[0], ret[1]);
    } finally {
        wasm.__wbindgen_free(deferred2_0, deferred2_1, 1);
    }
}

/**
 * Evaluate a Lingo expression and return the result as JSON.
 * Unlike eval_command, this waits for completion and returns the result.
 * @param {string} code
 * @returns {Promise<string>}
 */
export function mcp_eval_lingo(code) {
    const ptr0 = passStringToWasm0(code, wasm.__wbindgen_malloc, wasm.__wbindgen_realloc);
    const len0 = WASM_VECTOR_LEN;
    const ret = wasm.mcp_eval_lingo(ptr0, len0);
    return ret;
}

/**
 * @param {number} depth
 * @param {boolean} include_locals
 * @returns {string}
 */
export function mcp_get_call_stack(depth, include_locals) {
    let deferred1_0;
    let deferred1_1;
    try {
        const ret = wasm.mcp_get_call_stack(depth, include_locals);
        deferred1_0 = ret[0];
        deferred1_1 = ret[1];
        return getStringFromWasm0(ret[0], ret[1]);
    } finally {
        wasm.__wbindgen_free(deferred1_0, deferred1_1, 1);
    }
}

/**
 * @param {number} last_n_lines
 * @returns {string}
 */
export function mcp_get_console_output(last_n_lines) {
    let deferred1_0;
    let deferred1_1;
    try {
        const ret = wasm.mcp_get_console_output(last_n_lines);
        deferred1_0 = ret[0];
        deferred1_1 = ret[1];
        return getStringFromWasm0(ret[0], ret[1]);
    } finally {
        wasm.__wbindgen_free(deferred1_0, deferred1_1, 1);
    }
}

/**
 * @returns {string}
 */
export function mcp_get_context() {
    let deferred1_0;
    let deferred1_1;
    try {
        const ret = wasm.mcp_get_context();
        deferred1_0 = ret[0];
        deferred1_1 = ret[1];
        return getStringFromWasm0(ret[0], ret[1]);
    } finally {
        wasm.__wbindgen_free(deferred1_0, deferred1_1, 1);
    }
}

/**
 * @returns {string}
 */
export function mcp_get_execution_state() {
    let deferred1_0;
    let deferred1_1;
    try {
        const ret = wasm.mcp_get_execution_state();
        deferred1_0 = ret[0];
        deferred1_1 = ret[1];
        return getStringFromWasm0(ret[0], ret[1]);
    } finally {
        wasm.__wbindgen_free(deferred1_0, deferred1_1, 1);
    }
}

/**
 * @returns {string}
 */
export function mcp_get_globals() {
    let deferred1_0;
    let deferred1_1;
    try {
        const ret = wasm.mcp_get_globals();
        deferred1_0 = ret[0];
        deferred1_1 = ret[1];
        return getStringFromWasm0(ret[0], ret[1]);
    } finally {
        wasm.__wbindgen_free(deferred1_0, deferred1_1, 1);
    }
}

/**
 * @param {number} scope_index
 * @returns {string}
 */
export function mcp_get_locals(scope_index) {
    let deferred1_0;
    let deferred1_1;
    try {
        const ret = wasm.mcp_get_locals(scope_index);
        deferred1_0 = ret[0];
        deferred1_1 = ret[1];
        return getStringFromWasm0(ret[0], ret[1]);
    } finally {
        wasm.__wbindgen_free(deferred1_0, deferred1_1, 1);
    }
}

/**
 * @param {number} cast_lib
 * @param {number} cast_member
 * @returns {string}
 */
export function mcp_get_script(cast_lib, cast_member) {
    let deferred1_0;
    let deferred1_1;
    try {
        const ret = wasm.mcp_get_script(cast_lib, cast_member);
        deferred1_0 = ret[0];
        deferred1_1 = ret[1];
        return getStringFromWasm0(ret[0], ret[1]);
    } finally {
        wasm.__wbindgen_free(deferred1_0, deferred1_1, 1);
    }
}

/**
 * @param {number} cast_lib
 * @param {number} cast_member
 * @returns {string}
 */
export function mcp_inspect_cast_member(cast_lib, cast_member) {
    let deferred1_0;
    let deferred1_1;
    try {
        const ret = wasm.mcp_inspect_cast_member(cast_lib, cast_member);
        deferred1_0 = ret[0];
        deferred1_1 = ret[1];
        return getStringFromWasm0(ret[0], ret[1]);
    } finally {
        wasm.__wbindgen_free(deferred1_0, deferred1_1, 1);
    }
}

/**
 * @param {number} datum_id
 * @returns {string}
 */
export function mcp_inspect_datum(datum_id) {
    let deferred1_0;
    let deferred1_1;
    try {
        const ret = wasm.mcp_inspect_datum(datum_id);
        deferred1_0 = ret[0];
        deferred1_1 = ret[1];
        return getStringFromWasm0(ret[0], ret[1]);
    } finally {
        wasm.__wbindgen_free(deferred1_0, deferred1_1, 1);
    }
}

/**
 * @returns {string}
 */
export function mcp_list_breakpoints() {
    let deferred1_0;
    let deferred1_1;
    try {
        const ret = wasm.mcp_list_breakpoints();
        deferred1_0 = ret[0];
        deferred1_1 = ret[1];
        return getStringFromWasm0(ret[0], ret[1]);
    } finally {
        wasm.__wbindgen_free(deferred1_0, deferred1_1, 1);
    }
}

/**
 * @returns {string}
 */
export function mcp_list_cast_libs() {
    let deferred1_0;
    let deferred1_1;
    try {
        const ret = wasm.mcp_list_cast_libs();
        deferred1_0 = ret[0];
        deferred1_1 = ret[1];
        return getStringFromWasm0(ret[0], ret[1]);
    } finally {
        wasm.__wbindgen_free(deferred1_0, deferred1_1, 1);
    }
}

/**
 * @param {number} cast_lib
 * @returns {string}
 */
export function mcp_list_cast_members(cast_lib) {
    let deferred1_0;
    let deferred1_1;
    try {
        const ret = wasm.mcp_list_cast_members(cast_lib);
        deferred1_0 = ret[0];
        deferred1_1 = ret[1];
        return getStringFromWasm0(ret[0], ret[1]);
    } finally {
        wasm.__wbindgen_free(deferred1_0, deferred1_1, 1);
    }
}

/**
 * @param {number} cast_lib
 * @param {number} limit
 * @param {number} offset
 * @returns {string}
 */
export function mcp_list_scripts(cast_lib, limit, offset) {
    let deferred1_0;
    let deferred1_1;
    try {
        const ret = wasm.mcp_list_scripts(cast_lib, limit, offset);
        deferred1_0 = ret[0];
        deferred1_1 = ret[1];
        return getStringFromWasm0(ret[0], ret[1]);
    } finally {
        wasm.__wbindgen_free(deferred1_0, deferred1_1, 1);
    }
}

/**
 * @param {number} x
 * @param {number} y
 */
export function mouse_down(x, y) {
    wasm.mouse_down(x, y);
}

/**
 * @param {number} x
 * @param {number} y
 */
export function mouse_move(x, y) {
    wasm.mouse_move(x, y);
}

/**
 * Mouse move with delta values (for pointer lock mode).
 * The delta is added to the current mouse_loc (which the game resets to center each
 * frame), so `the mouseH` tracks pointer-lock movementX. X must be ADDED, not
 * subtracted: `the mouseH` increases to the right (screen coords), so moving the
 * mouse right (movementX > 0) must increase mouseH → the movie yaws right. The
 * previous `-= dx` inverted horizontal look (move left → turn right).
 * @param {number} dx
 * @param {number} dy
 */
export function mouse_move_delta(dx, dy) {
    wasm.mouse_move_delta(dx, dy);
}

/**
 * @param {number} x
 * @param {number} y
 */
export function mouse_up(x, y) {
    wasm.mouse_up(x, y);
}

/**
 * Returns the currently-loaded movie's declared xtra dependencies
 * (parsed from its XTRl chunk). Each entry is a `js_sys::Object` with
 * `filename` (always present) and `displayName` (may be empty if the
 * movie's entry only had a filename).
 *
 * JS-side hosts call this right after `load_movie_file` to resolve
 * each declared xtra against the host's name->URL registry, fetching
 * any plugins that aren't loaded yet.
 *
 * Returns an empty array if no movie is loaded or the movie has no
 * XTRl chunk (older Director versions, lightweight movies).
 * @returns {Array<any>}
 */
export function movie_required_xtras() {
    const ret = wasm.movie_required_xtras();
    return ret;
}

/**
 * Insert text at the focused editable member's caret/selection. Used by
 * paste and IME commit.
 * @param {string} text
 */
export function paste_text_into_focused_field(text) {
    const ptr0 = passStringToWasm0(text, wasm.__wbindgen_malloc, wasm.__wbindgen_realloc);
    const len0 = WASM_VECTOR_LEN;
    wasm.paste_text_into_focused_field(ptr0, len0);
}

export function play() {
    wasm.play();
}

export function player_create_canvas() {
    const ret = wasm.player_create_canvas();
    if (ret[1]) {
        throw takeFromExternrefTable0(ret[0]);
    }
}

/**
 * @param {number} x
 * @param {number} y
 * @returns {number}
 */
export function player_get_mouse_sprite_at(x, y) {
    const ret = wasm.player_get_mouse_sprite_at(x, y);
    return ret;
}

/**
 * @param {number} x
 * @param {number} y
 * @returns {number}
 */
export function player_get_sprite_at(x, y) {
    const ret = wasm.player_get_sprite_at(x, y);
    return ret;
}

/**
 * Dev UI sound preview: play a sound member on channel 1 via the real
 * puppetSound path. Routed through the command queue so playback starts at a
 * safe point; the triggering button click satisfies the audio-gesture gate.
 * @param {number} cast_lib
 * @param {number} cast_member
 */
export function player_play_member_sound(cast_lib, cast_member) {
    wasm.player_play_member_sound(cast_lib, cast_member);
}

/**
 * Dump every authored child sprite inside a filmloop member to the browser
 * console. Lingo can't reach a filmloop's child sprites directly (the
 * member.media is opaque), so this exposes the parsed score state
 * dirplayer-rs already holds in memory. Resolves keyframes the same way
 * `render_filmloop_from_channel_data` does (most-recent frame_idx per
 * channel up to current_frame). Call from the JS console:
 *   `vm.player_print_filmloop_sprites(2, 145)` for the spiderweb filmloop.
 * @param {number} cast_lib
 * @param {number} cast_member
 */
export function player_print_filmloop_sprites(cast_lib, cast_member) {
    wasm.player_print_filmloop_sprites(cast_lib, cast_member);
}

/**
 * @param {number} cast_lib
 * @param {number} cast_member
 */
export function player_print_member_bitmap_hex(cast_lib, cast_member) {
    wasm.player_print_member_bitmap_hex(cast_lib, cast_member);
}

/**
 * Dev UI sound preview: dump a sound member's decoded header fields plus the
 * first 256 raw bytes (hex + ASCII) to the browser console. Lets a sound that
 * "doesn't play" be identified by its real format magic (RIFF/WAV, FORM/AIFF,
 * ID3 or 0xFF Ex = MP3, otherwise raw PCM) versus what the member metadata
 * claims. Read-only, so it resolves the member synchronously.
 * @param {number} cast_lib
 * @param {number} cast_member
 */
export function player_print_member_sound_hex(cast_lib, cast_member) {
    wasm.player_print_member_sound_hex(cast_lib, cast_member);
}

/**
 * @param {number} channel_num
 */
export function player_set_debug_selected_channel(channel_num) {
    const ret = wasm.player_set_debug_selected_channel(channel_num);
    if (ret[1]) {
        throw takeFromExternrefTable0(ret[0]);
    }
}

/**
 * @param {boolean} enabled
 */
export function player_set_picking_mode(enabled) {
    wasm.player_set_picking_mode(enabled);
}

/**
 * @param {number} size
 */
export function player_set_preview_font_size(size) {
    const ret = wasm.player_set_preview_font_size(size);
    if (ret[1]) {
        throw takeFromExternrefTable0(ret[0]);
    }
}

/**
 * @param {number} cast_lib
 * @param {number} cast_num
 */
export function player_set_preview_member_ref(cast_lib, cast_num) {
    const ret = wasm.player_set_preview_member_ref(cast_lib, cast_num);
    if (ret[1]) {
        throw takeFromExternrefTable0(ret[0]);
    }
}

/**
 * @param {string} parent_selector
 */
export function player_set_preview_parent(parent_selector) {
    const ptr0 = passStringToWasm0(parent_selector, wasm.__wbindgen_malloc, wasm.__wbindgen_realloc);
    const len0 = WASM_VECTOR_LEN;
    const ret = wasm.player_set_preview_parent(ptr0, len0);
    if (ret[1]) {
        throw takeFromExternrefTable0(ret[0]);
    }
}

/**
 * @param {string} backend
 */
export function player_set_renderer_backend(backend) {
    const ptr0 = passStringToWasm0(backend, wasm.__wbindgen_malloc, wasm.__wbindgen_realloc);
    const len0 = WASM_VECTOR_LEN;
    const ret = wasm.player_set_renderer_backend(ptr0, len0);
    if (ret[1]) {
        throw takeFromExternrefTable0(ret[0]);
    }
}

/**
 * @param {number} task_id
 * @param {Uint8Array} data
 */
export function provide_net_task_data(task_id, data) {
    const ptr0 = passArray8ToWasm0(data, wasm.__wbindgen_malloc);
    const len0 = WASM_VECTOR_LEN;
    wasm.provide_net_task_data(task_id, ptr0, len0);
}

/**
 * @param {number} task_id
 */
export function provide_net_task_error(task_id) {
    wasm.provide_net_task_error(task_id);
}

/**
 * Register an externally-loaded plugin under its xtra name. Subsequent
 * Lingo dispatches (`new(xtra "name")`, `the xtraList`, etc.) will route
 * to the external plugin via the JS bridge. Case-insensitive.
 * @param {string} name
 */
export function register_external_xtra(name) {
    const ptr0 = passStringToWasm0(name, wasm.__wbindgen_malloc, wasm.__wbindgen_realloc);
    const len0 = WASM_VECTOR_LEN;
    wasm.register_external_xtra(ptr0, len0);
}

/**
 * @param {string} script_name
 * @param {string} handler_name
 * @param {number} bytecode_index
 */
export function remove_breakpoint(script_name, handler_name, bytecode_index) {
    const ptr0 = passStringToWasm0(script_name, wasm.__wbindgen_malloc, wasm.__wbindgen_realloc);
    const len0 = WASM_VECTOR_LEN;
    const ptr1 = passStringToWasm0(handler_name, wasm.__wbindgen_malloc, wasm.__wbindgen_realloc);
    const len1 = WASM_VECTOR_LEN;
    wasm.remove_breakpoint(ptr0, len0, ptr1, len1, bytecode_index);
}

/**
 * @param {number} datum_id
 */
export function request_datum(datum_id) {
    wasm.request_datum(datum_id);
}

/**
 * @param {number} script_instance_id
 */
export function request_script_instance_snapshot(script_instance_id) {
    wasm.request_script_instance_snapshot(script_instance_id);
}

export function reset() {
    wasm.reset();
}

export function reset_interp_stats() {
    wasm.reset_interp_stats();
}

export function resume_breakpoint() {
    wasm.resume_breakpoint();
}

/**
 * Right-mouse-button down. Tracked via a separate flag because Director
 * scripts use `the rightMouseDown` to gate right-drag behaviour. Position
 * is updated alongside so `the mouseLoc` reflects the click point.
 * @param {number} x
 * @param {number} y
 */
export function right_mouse_down(x, y) {
    wasm.right_mouse_down(x, y);
}

/**
 * @param {number} x
 * @param {number} y
 */
export function right_mouse_up(x, y) {
    wasm.right_mouse_up(x, y);
}

/**
 * Host mute leaves the game clock and authored sound controls running.
 * @param {boolean} muted
 */
export function set_audio_muted(muted) {
    wasm.set_audio_muted(muted);
}

/**
 * @param {string} path
 */
export function set_base_path(path) {
    const ptr0 = passStringToWasm0(path, wasm.__wbindgen_malloc, wasm.__wbindgen_realloc);
    const len0 = WASM_VECTOR_LEN;
    wasm.set_base_path(ptr0, len0);
}

/**
 * @param {boolean} enabled
 */
export function set_break_on_error(enabled) {
    wasm.set_break_on_error(enabled);
}

/**
 * Update the VM-side mirror of the OS clipboard so Lingo `the clipBoard`
 * reads back what was last copied via the JS gesture event. The OS clipboard
 * itself remains the source of truth; this is purely so scripts can observe
 * what the user just copied/cut.
 * @param {string} text
 */
export function set_clipboard_mirror(text) {
    const ptr0 = passStringToWasm0(text, wasm.__wbindgen_malloc, wasm.__wbindgen_realloc);
    const len0 = WASM_VECTOR_LEN;
    wasm.set_clipboard_mirror(ptr0, len0);
}

/**
 * @param {number} index
 */
export function set_eval_scope_index(index) {
    wasm.set_eval_scope_index(index);
}

/**
 * @param {object} params
 */
export function set_external_params(params) {
    wasm.set_external_params(params);
}

/**
 * Set glyph rendering preference for text/field members.
 * Values: "auto" (default), "bitmap" (PFR atlas), "native" (Canvas2D fillText),
 *         "outline" (force outline rasterization, skip PFR bitmap strikes — needs clear_font_cache)
 * @param {string} mode
 */
export function set_glyph_preference(mode) {
    const ptr0 = passStringToWasm0(mode, wasm.__wbindgen_malloc, wasm.__wbindgen_realloc);
    const len0 = WASM_VECTOR_LEN;
    wasm.set_glyph_preference(ptr0, len0);
}

/**
 * @param {boolean} enabled
 */
export function set_interp_stats_enabled(enabled) {
    wasm.set_interp_stats_enabled(enabled);
}

/**
 * Run a synthetic Lingo bytecode-throughput benchmark in the live (browser)
 * interpreter and return a human-readable report (ops/sec, ns/op). Call from
 * the DevTools console after a movie has loaded to measure real WASM per-op
 * cost. Requires an initialized player.
 * Turn the register-IR execution path on or off at runtime, so a movie can be
 * A/B'd in one session instead of one 6-minute wasm build per data point.
 * Returns the value now in effect.
 * @param {boolean} enabled
 * @returns {boolean}
 */
export function set_ir_enabled(enabled) {
    const ret = wasm.set_ir_enabled(enabled);
    return ret !== 0;
}

/**
 * @param {number} cast_lib
 * @param {number} cast_member
 * @param {string} prop_name
 * @param {any} value
 * @returns {boolean}
 */
export function set_lingo_script_property(cast_lib, cast_member, prop_name, value) {
    const ptr0 = passStringToWasm0(prop_name, wasm.__wbindgen_malloc, wasm.__wbindgen_realloc);
    const len0 = WASM_VECTOR_LEN;
    const ret = wasm.set_lingo_script_property(cast_lib, cast_member, ptr0, len0, value);
    return ret !== 0;
}

/**
 * Like `set_movie_path_override` but does NOT register the path with the
 * net manager for URL rewriting. The given path becomes what `the
 * moviePath` / `the movieName` return; URLs the script builds from it
 * (e.g. `postNetText(the moviePath & "x.aspx")`) go out unchanged for
 * the JS-side fetch interceptor / proxy to handle.
 *
 * Use this when you've already wired up host-based proxying on the
 * JS/dev-server side (see `flashPlayerManager.ts::applyFetchRewrite`)
 * and you only want to advertise a "real" path to the movie without
 * dirplayer rewriting any URLs that result.
 * @param {string} path
 */
export function set_movie_path_label(path) {
    const ptr0 = passStringToWasm0(path, wasm.__wbindgen_malloc, wasm.__wbindgen_realloc);
    const len0 = WASM_VECTOR_LEN;
    wasm.set_movie_path_label(ptr0, len0);
}

/**
 * @param {string} path
 */
export function set_movie_path_override(path) {
    const ptr0 = passStringToWasm0(path, wasm.__wbindgen_malloc, wasm.__wbindgen_realloc);
    const len0 = WASM_VECTOR_LEN;
    wasm.set_movie_path_override(ptr0, len0);
}

/**
 * Set whether PFR font rasterization is enabled
 * @param {boolean} enabled
 */
export function set_pfr_font_enabled(enabled) {
    wasm.set_pfr_font_enabled(enabled);
}

/**
 * Switch the renderer backend at runtime
 * @param {string} backend
 */
export function set_renderer_backend(backend) {
    const ptr0 = passStringToWasm0(backend, wasm.__wbindgen_malloc, wasm.__wbindgen_realloc);
    const len0 = WASM_VECTOR_LEN;
    const ret = wasm.set_renderer_backend(ptr0, len0);
    if (ret[1]) {
        throw takeFromExternrefTable0(ret[0]);
    }
}

/**
 * @param {number} width
 * @param {number} height
 */
export function set_stage_size(width, height) {
    wasm.set_stage_size(width, height);
}

/**
 * The Shockwave projector's `--do` launch argument: Lingo evaluated once,
 * immediately before the launched movie's `prepareMovie`.
 *
 * Archived titles are often launched through a wrapper movie that the
 * projector has to seed first — Agent Free Ride's Flashpoint entry is
 * `"…/wrapper_silentbaystudios.dcr" --do "member('gameUrl').text = '…'"`,
 * and the wrapper cannot redirect without it because the member ships empty.
 *
 * Call before `load_movie_*`. Single-quoted strings in the payload are
 * accepted as the launcher writes them (see `normalize_startup_do_quotes`).
 * @param {string} code
 */
export function set_startup_do(code) {
    const ptr0 = passStringToWasm0(code, wasm.__wbindgen_malloc, wasm.__wbindgen_realloc);
    const len0 = WASM_VECTOR_LEN;
    wasm.set_startup_do(ptr0, len0);
}

/**
 * The projector's `--doBefore`: Lingo evaluated once BEFORE the movie loads.
 * @param {string} code
 */
export function set_startup_do_before(code) {
    const ptr0 = passStringToWasm0(code, wasm.__wbindgen_malloc, wasm.__wbindgen_realloc);
    const len0 = WASM_VECTOR_LEN;
    wasm.set_startup_do_before(ptr0, len0);
}

/**
 * The projector's `--go N`: jump to frame `N` once the movie has started.
 * Pass 0 to clear.
 * @param {number} frame
 */
export function set_startup_go(frame) {
    wasm.set_startup_go(frame);
}

/**
 * @param {string} path
 */
export function set_system_font_path(path) {
    const ptr0 = passStringToWasm0(path, wasm.__wbindgen_malloc, wasm.__wbindgen_realloc);
    const len0 = WASM_VECTOR_LEN;
    wasm.set_system_font_path(ptr0, len0);
}

export function start() {
    wasm.start();
}

/**
 * Begin recording a speedscope profile of Lingo VM execution (handlers +
 * bytecode ops). Clears any previously recorded events.
 */
export function start_profiling_recording() {
    wasm.start_profiling_recording();
}

export function step_into() {
    wasm.step_into();
}

/**
 * @param {Uint32Array} skip_bytecode_indices
 */
export function step_into_line(skip_bytecode_indices) {
    const ptr0 = passArray32ToWasm0(skip_bytecode_indices, wasm.__wbindgen_malloc);
    const len0 = WASM_VECTOR_LEN;
    wasm.step_into_line(ptr0, len0);
}

export function step_out() {
    wasm.step_out();
}

export function step_over() {
    wasm.step_over();
}

/**
 * @param {Uint32Array} skip_bytecode_indices
 */
export function step_over_line(skip_bytecode_indices) {
    const ptr0 = passArray32ToWasm0(skip_bytecode_indices, wasm.__wbindgen_malloc);
    const len0 = WASM_VECTOR_LEN;
    wasm.step_over_line(ptr0, len0);
}

export function stop() {
    wasm.stop();
}

/**
 * Stop recording. Buffered events stay available for `export_profiling_speedscope`.
 */
export function stop_profiling_recording() {
    wasm.stop_profiling_recording();
}

/**
 * Same deal per cast library: only the ones the cast inspector has expanded
 * get their member lists serialized.
 * @param {number} cast_number
 */
export function subscribe_to_cast_member_list(cast_number) {
    wasm.subscribe_to_cast_member_list(cast_number);
}

export function subscribe_to_channel_names() {
    wasm.subscribe_to_channel_names();
}

/**
 * @param {number} cast_lib
 * @param {number} cast_member
 */
export function subscribe_to_member(cast_lib, cast_member) {
    wasm.subscribe_to_member(cast_lib, cast_member);
}

/**
 * The score inspector is showing: start pushing score snapshots, and send the
 * current one right away. Nothing is pushed while unsubscribed — a full score
 * snapshot is tens of thousands of objects and ordinary playback needs none of
 * it.
 */
export function subscribe_to_score() {
    wasm.subscribe_to_score();
}

/**
 * @param {string} script_name
 * @param {string} handler_name
 * @param {number} bytecode_index
 */
export function toggle_breakpoint(script_name, handler_name, bytecode_index) {
    const ptr0 = passStringToWasm0(script_name, wasm.__wbindgen_malloc, wasm.__wbindgen_realloc);
    const len0 = WASM_VECTOR_LEN;
    const ptr1 = passStringToWasm0(handler_name, wasm.__wbindgen_malloc, wasm.__wbindgen_realloc);
    const len1 = WASM_VECTOR_LEN;
    wasm.toggle_breakpoint(ptr0, len0, ptr1, len1, bytecode_index);
}

export function trigger_alert_hook() {
    wasm.trigger_alert_hook();
}

/**
 * @param {number} sprite_num
 * @param {string} handler_name
 * @param {any} args
 * @returns {boolean}
 */
export function trigger_lingo_callback(sprite_num, handler_name, args) {
    const ptr0 = passStringToWasm0(handler_name, wasm.__wbindgen_malloc, wasm.__wbindgen_realloc);
    const len0 = WASM_VECTOR_LEN;
    const ret = wasm.trigger_lingo_callback(sprite_num, ptr0, len0, args);
    return ret !== 0;
}

/**
 * @param {number} cast_lib
 * @param {number} cast_member
 * @param {string} handler_name
 * @param {string} args
 * @param {number} flash_cast_lib
 * @param {number} flash_cast_member
 * @returns {boolean}
 */
export function trigger_lingo_callback_on_script(cast_lib, cast_member, handler_name, args, flash_cast_lib, flash_cast_member) {
    const ptr0 = passStringToWasm0(handler_name, wasm.__wbindgen_malloc, wasm.__wbindgen_realloc);
    const len0 = WASM_VECTOR_LEN;
    const ptr1 = passStringToWasm0(args, wasm.__wbindgen_malloc, wasm.__wbindgen_realloc);
    const len1 = WASM_VECTOR_LEN;
    const ret = wasm.trigger_lingo_callback_on_script(cast_lib, cast_member, ptr0, len0, ptr1, len1, flash_cast_lib, flash_cast_member);
    return ret !== 0;
}

/**
 * @param {string} name
 */
export function trigger_timeout(name) {
    const ptr0 = passStringToWasm0(name, wasm.__wbindgen_malloc, wasm.__wbindgen_realloc);
    const len0 = WASM_VECTOR_LEN;
    wasm.trigger_timeout(ptr0, len0);
}

/**
 * @param {number} cast_number
 */
export function unsubscribe_from_cast_member_list(cast_number) {
    wasm.unsubscribe_from_cast_member_list(cast_number);
}

export function unsubscribe_from_channel_names() {
    wasm.unsubscribe_from_channel_names();
}

/**
 * @param {number} cast_lib
 * @param {number} cast_member
 */
export function unsubscribe_from_member(cast_lib, cast_member) {
    wasm.unsubscribe_from_member(cast_lib, cast_member);
}

export function unsubscribe_from_score() {
    wasm.unsubscribe_from_score();
}

/**
 * Receive a rendered Flash frame from JavaScript (Ruffle) and store it as a
 * per-sprite bitmap. Each Flash sprite has its own Ruffle player instance
 * (so multiple sprites that share a single Flash cast member can display
 * different frames at the same time — e.g. storyscramble's 3 story tiles
 * pinned to poster frames 2/4/6 of one shared SWF). The renderer reads
 * `flash_frame_buffers[sprite_num]` directly.
 * @param {number} sprite_num
 * @param {number} width
 * @param {number} height
 * @param {Uint8Array} rgba_data
 */
export function update_flash_frame(sprite_num, width, height, rgba_data) {
    const ptr0 = passArray8ToWasm0(rgba_data, wasm.__wbindgen_malloc);
    const len0 = WASM_VECTOR_LEN;
    wasm.update_flash_frame(sprite_num, width, height, ptr0, len0);
}

/**
 * Check if the game wants pointer lock (for FPS mouse look)
 * @returns {boolean}
 */
export function wants_pointer_lock() {
    const ret = wasm.wants_pointer_lock();
    return ret !== 0;
}
import * as import1 from "dirplayer-js-api"
import * as import2 from "dirplayer-js-api"
import * as import3 from "dirplayer-js-api"
import * as import4 from "dirplayer-js-api"
import * as import5 from "dirplayer-js-api"
import * as import6 from "dirplayer-js-api"
import * as import7 from "dirplayer-js-api"
import * as import8 from "dirplayer-js-api"
import * as import9 from "dirplayer-js-api"
import * as import10 from "dirplayer-js-api"
import * as import11 from "dirplayer-js-api"

function __wbg_get_imports() {
    const import0 = {
        __proto__: null,
        __wbg___wbindgen_boolean_get_bbbb1c18aa2f5e25: function(arg0) {
            const v = arg0;
            const ret = typeof(v) === 'boolean' ? v : undefined;
            return isLikeNone(ret) ? 0xFFFFFF : ret ? 1 : 0;
        },
        __wbg___wbindgen_debug_string_0bc8482c6e3508ae: function(arg0, arg1) {
            const ret = debugString(arg1);
            const ptr1 = passStringToWasm0(ret, wasm.__wbindgen_malloc, wasm.__wbindgen_realloc);
            const len1 = WASM_VECTOR_LEN;
            getDataViewMemory0().setInt32(arg0 + 4 * 1, len1, true);
            getDataViewMemory0().setInt32(arg0 + 4 * 0, ptr1, true);
        },
        __wbg___wbindgen_is_falsy_e623e5b815413d00: function(arg0) {
            const ret = !arg0;
            return ret;
        },
        __wbg___wbindgen_is_function_0095a73b8b156f76: function(arg0) {
            const ret = typeof(arg0) === 'function';
            return ret;
        },
        __wbg___wbindgen_is_null_ac34f5003991759a: function(arg0) {
            const ret = arg0 === null;
            return ret;
        },
        __wbg___wbindgen_is_object_5ae8e5880f2c1fbd: function(arg0) {
            const val = arg0;
            const ret = typeof(val) === 'object' && val !== null;
            return ret;
        },
        __wbg___wbindgen_is_string_cd444516edc5b180: function(arg0) {
            const ret = typeof(arg0) === 'string';
            return ret;
        },
        __wbg___wbindgen_is_undefined_9e4d92534c42d778: function(arg0) {
            const ret = arg0 === undefined;
            return ret;
        },
        __wbg___wbindgen_number_get_8ff4255516ccad3e: function(arg0, arg1) {
            const obj = arg1;
            const ret = typeof(obj) === 'number' ? obj : undefined;
            getDataViewMemory0().setFloat64(arg0 + 8 * 1, isLikeNone(ret) ? 0 : ret, true);
            getDataViewMemory0().setInt32(arg0 + 4 * 0, !isLikeNone(ret), true);
        },
        __wbg___wbindgen_string_get_72fb696202c56729: function(arg0, arg1) {
            const obj = arg1;
            const ret = typeof(obj) === 'string' ? obj : undefined;
            var ptr1 = isLikeNone(ret) ? 0 : passStringToWasm0(ret, wasm.__wbindgen_malloc, wasm.__wbindgen_realloc);
            var len1 = WASM_VECTOR_LEN;
            getDataViewMemory0().setInt32(arg0 + 4 * 1, len1, true);
            getDataViewMemory0().setInt32(arg0 + 4 * 0, ptr1, true);
        },
        __wbg___wbindgen_throw_be289d5034ed271b: function(arg0, arg1) {
            throw new Error(getStringFromWasm0(arg0, arg1));
        },
        __wbg__wbg_cb_unref_d9b87ff7982e3b21: function(arg0) {
            arg0._wbg_cb_unref();
        },
        __wbg_activeTexture_6f9a710514686c24: function(arg0, arg1) {
            arg0.activeTexture(arg1 >>> 0);
        },
        __wbg_addEventListener_3acb0aad4483804c: function() { return handleError(function (arg0, arg1, arg2, arg3) {
            arg0.addEventListener(getStringFromWasm0(arg1, arg2), arg3);
        }, arguments); },
        __wbg_alert_6961e77eb545540e: function() { return handleError(function (arg0, arg1, arg2) {
            arg0.alert(getStringFromWasm0(arg1, arg2));
        }, arguments); },
        __wbg_appendChild_dea38765a26d346d: function() { return handleError(function (arg0, arg1) {
            const ret = arg0.appendChild(arg1);
            return ret;
        }, arguments); },
        __wbg_append_a992ccc37aa62dc4: function() { return handleError(function (arg0, arg1, arg2, arg3, arg4) {
            arg0.append(getStringFromWasm0(arg1, arg2), getStringFromWasm0(arg3, arg4));
        }, arguments); },
        __wbg_append_f397817515023c29: function() { return handleError(function (arg0, arg1, arg2, arg3, arg4) {
            arg0.append(getStringFromWasm0(arg1, arg2), getStringFromWasm0(arg3, arg4));
        }, arguments); },
        __wbg_apply_2e22c45cb4f12415: function() { return handleError(function (arg0, arg1, arg2) {
            const ret = Reflect.apply(arg0, arg1, arg2);
            return ret;
        }, arguments); },
        __wbg_apply_ada2ee1a60ac7b3c: function() { return handleError(function (arg0, arg1, arg2) {
            const ret = arg0.apply(arg1, arg2);
            return ret;
        }, arguments); },
        __wbg_arrayBuffer_bb54076166006c39: function() { return handleError(function (arg0) {
            const ret = arg0.arrayBuffer();
            return ret;
        }, arguments); },
        __wbg_attachShader_b36058e5c9eeaf54: function(arg0, arg1, arg2) {
            arg0.attachShader(arg1, arg2);
        },
        __wbg_beginPath_9873f939d695759c: function(arg0) {
            arg0.beginPath();
        },
        __wbg_bezierCurveTo_38509204f815cfd5: function(arg0, arg1, arg2, arg3, arg4, arg5, arg6) {
            arg0.bezierCurveTo(arg1, arg2, arg3, arg4, arg5, arg6);
        },
        __wbg_bindBuffer_c9068e8712a034f5: function(arg0, arg1, arg2) {
            arg0.bindBuffer(arg1 >>> 0, arg2);
        },
        __wbg_bindFramebuffer_031c73ba501cb8f6: function(arg0, arg1, arg2) {
            arg0.bindFramebuffer(arg1 >>> 0, arg2);
        },
        __wbg_bindRenderbuffer_8a2aa4e3d1fb5443: function(arg0, arg1, arg2) {
            arg0.bindRenderbuffer(arg1 >>> 0, arg2);
        },
        __wbg_bindTexture_b2b7b1726a83f93e: function(arg0, arg1, arg2) {
            arg0.bindTexture(arg1 >>> 0, arg2);
        },
        __wbg_bindVertexArray_78220d1edb1d2382: function(arg0, arg1) {
            arg0.bindVertexArray(arg1);
        },
        __wbg_blendEquation_e9b99928ed1494ad: function(arg0, arg1) {
            arg0.blendEquation(arg1 >>> 0);
        },
        __wbg_blendFuncSeparate_95465944f788a092: function(arg0, arg1, arg2, arg3, arg4) {
            arg0.blendFuncSeparate(arg1 >>> 0, arg2 >>> 0, arg3 >>> 0, arg4 >>> 0);
        },
        __wbg_blendFunc_2ef59299d10c662d: function(arg0, arg1, arg2) {
            arg0.blendFunc(arg1 >>> 0, arg2 >>> 0);
        },
        __wbg_blob_b7b95bd9656ac95c: function() { return handleError(function (arg0) {
            const ret = arg0.blob();
            return ret;
        }, arguments); },
        __wbg_body_3a0b4437dadea6bf: function(arg0) {
            const ret = arg0.body;
            return isLikeNone(ret) ? 0 : addToExternrefTable0(ret);
        },
        __wbg_body_f67922363a220026: function(arg0) {
            const ret = arg0.body;
            return isLikeNone(ret) ? 0 : addToExternrefTable0(ret);
        },
        __wbg_bufferData_98f6c413a8f0f139: function(arg0, arg1, arg2, arg3) {
            arg0.bufferData(arg1 >>> 0, arg2, arg3 >>> 0);
        },
        __wbg_buffer_26d0910f3a5bc899: function(arg0) {
            const ret = arg0.buffer;
            return ret;
        },
        __wbg_call_389efe28435a9388: function() { return handleError(function (arg0, arg1) {
            const ret = arg0.call(arg1);
            return ret;
        }, arguments); },
        __wbg_call_4708e0c13bdc8e95: function() { return handleError(function (arg0, arg1, arg2) {
            const ret = arg0.call(arg1, arg2);
            return ret;
        }, arguments); },
        __wbg_call_812d25f1510c13c8: function() { return handleError(function (arg0, arg1, arg2, arg3) {
            const ret = arg0.call(arg1, arg2, arg3);
            return ret;
        }, arguments); },
        __wbg_canvas_ba5097339b091f27: function(arg0) {
            const ret = arg0.canvas;
            return isLikeNone(ret) ? 0 : addToExternrefTable0(ret);
        },
        __wbg_clearColor_404a3b16d43db93b: function(arg0, arg1, arg2, arg3, arg4) {
            arg0.clearColor(arg1, arg2, arg3, arg4);
        },
        __wbg_clearRect_1eed255045515c55: function(arg0, arg1, arg2, arg3, arg4) {
            arg0.clearRect(arg1, arg2, arg3, arg4);
        },
        __wbg_clearTimeout_5a54f8841c30079a: function(arg0) {
            const ret = clearTimeout(arg0);
            return ret;
        },
        __wbg_clear_7187030f892c5ca0: function(arg0, arg1) {
            arg0.clear(arg1 >>> 0);
        },
        __wbg_click_0e9c20848b655ed3: function(arg0) {
            arg0.click();
        },
        __wbg_clipboard_98c5a32249fa8416: function(arg0) {
            const ret = arg0.clipboard;
            return ret;
        },
        __wbg_closePath_de4e48859360b1b1: function(arg0) {
            arg0.closePath();
        },
        __wbg_code_a552f1e91eda69b7: function(arg0) {
            const ret = arg0.code;
            return ret;
        },
        __wbg_colorDepth_01117dd63f9788dc: function() { return handleError(function (arg0) {
            const ret = arg0.colorDepth;
            return ret;
        }, arguments); },
        __wbg_colorMask_177d9762658e5e28: function(arg0, arg1, arg2, arg3, arg4) {
            arg0.colorMask(arg1 !== 0, arg2 !== 0, arg3 !== 0, arg4 !== 0);
        },
        __wbg_compileShader_94718a93495d565d: function(arg0, arg1) {
            arg0.compileShader(arg1);
        },
        __wbg_connect_aba749effbe588ea: function() { return handleError(function (arg0, arg1) {
            const ret = arg0.connect(arg1);
            return ret;
        }, arguments); },
        __wbg_copyTexImage2D_07e641a3bc0c30e2: function(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8) {
            arg0.copyTexImage2D(arg1 >>> 0, arg2, arg3 >>> 0, arg4, arg5, arg6, arg7, arg8);
        },
        __wbg_copyTexSubImage2D_91ebcd9cd1908265: function(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8) {
            arg0.copyTexSubImage2D(arg1 >>> 0, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        },
        __wbg_copyToChannel_4bfc91363fcbe558: function() { return handleError(function (arg0, arg1, arg2, arg3) {
            arg0.copyToChannel(getArrayF32FromWasm0(arg1, arg2), arg3);
        }, arguments); },
        __wbg_createBufferSource_1254cd048e6c0593: function() { return handleError(function (arg0) {
            const ret = arg0.createBufferSource();
            return ret;
        }, arguments); },
        __wbg_createBufferSource_c8fdd9b92bc42f95: function() { return handleError(function (arg0) {
            const ret = arg0.createBufferSource();
            return ret;
        }, arguments); },
        __wbg_createBuffer_26534c05e01b8559: function(arg0) {
            const ret = arg0.createBuffer();
            return isLikeNone(ret) ? 0 : addToExternrefTable0(ret);
        },
        __wbg_createBuffer_36fe5fb1d9f77b9d: function() { return handleError(function (arg0, arg1, arg2, arg3) {
            const ret = arg0.createBuffer(arg1 >>> 0, arg2 >>> 0, arg3);
            return ret;
        }, arguments); },
        __wbg_createElement_49f60fdcaae809c8: function() { return handleError(function (arg0, arg1, arg2) {
            const ret = arg0.createElement(getStringFromWasm0(arg1, arg2));
            return ret;
        }, arguments); },
        __wbg_createExternalXtraInstance_7b3fe935bd707b25: function(arg0, arg1, arg2, arg3, arg4) {
            const ret = createExternalXtraInstance(getStringFromWasm0(arg1, arg2), getArrayU8FromWasm0(arg3, arg4));
            var ptr1 = isLikeNone(ret) ? 0 : passArray8ToWasm0(ret, wasm.__wbindgen_malloc);
            var len1 = WASM_VECTOR_LEN;
            getDataViewMemory0().setInt32(arg0 + 4 * 1, len1, true);
            getDataViewMemory0().setInt32(arg0 + 4 * 0, ptr1, true);
        },
        __wbg_createFramebuffer_41512c38358a41c4: function(arg0) {
            const ret = arg0.createFramebuffer();
            return isLikeNone(ret) ? 0 : addToExternrefTable0(ret);
        },
        __wbg_createGain_26f8f6d082c608c7: function() { return handleError(function (arg0) {
            const ret = arg0.createGain();
            return ret;
        }, arguments); },
        __wbg_createImageBitmap_5cc175ef98df91ee: function() { return handleError(function (arg0, arg1) {
            const ret = arg0.createImageBitmap(arg1);
            return ret;
        }, arguments); },
        __wbg_createObjectURL_918185db6a10a0c8: function() { return handleError(function (arg0, arg1) {
            const ret = URL.createObjectURL(arg1);
            const ptr1 = passStringToWasm0(ret, wasm.__wbindgen_malloc, wasm.__wbindgen_realloc);
            const len1 = WASM_VECTOR_LEN;
            getDataViewMemory0().setInt32(arg0 + 4 * 1, len1, true);
            getDataViewMemory0().setInt32(arg0 + 4 * 0, ptr1, true);
        }, arguments); },
        __wbg_createProgram_9b7710a1f2701c2c: function(arg0) {
            const ret = arg0.createProgram();
            return isLikeNone(ret) ? 0 : addToExternrefTable0(ret);
        },
        __wbg_createRenderbuffer_a601226a6a680dbe: function(arg0) {
            const ret = arg0.createRenderbuffer();
            return isLikeNone(ret) ? 0 : addToExternrefTable0(ret);
        },
        __wbg_createShader_e3ac08ed8c5b14b2: function(arg0, arg1) {
            const ret = arg0.createShader(arg1 >>> 0);
            return isLikeNone(ret) ? 0 : addToExternrefTable0(ret);
        },
        __wbg_createStereoPanner_41b5fc0ca10e6be4: function() { return handleError(function (arg0) {
            const ret = arg0.createStereoPanner();
            return ret;
        }, arguments); },
        __wbg_createTexture_16d2c8a3d7d4a75a: function(arg0) {
            const ret = arg0.createTexture();
            return isLikeNone(ret) ? 0 : addToExternrefTable0(ret);
        },
        __wbg_createVertexArray_ad5294951ae57497: function(arg0) {
            const ret = arg0.createVertexArray();
            return isLikeNone(ret) ? 0 : addToExternrefTable0(ret);
        },
        __wbg_crypto_e4b88bdecc3312df: function() { return handleError(function (arg0) {
            const ret = arg0.crypto;
            return ret;
        }, arguments); },
        __wbg_cullFace_e7e711a14d2c3f48: function(arg0, arg1) {
            arg0.cullFace(arg1 >>> 0);
        },
        __wbg_currentTime_6c7288048dba47fa: function(arg0) {
            const ret = arg0.currentTime;
            return ret;
        },
        __wbg_data_5330da50312d0bc1: function(arg0) {
            const ret = arg0.data;
            return ret;
        },
        __wbg_data_d52fd40cc1d7d4e8: function(arg0, arg1) {
            const ret = arg1.data;
            const ptr1 = passArray8ToWasm0(ret, wasm.__wbindgen_malloc);
            const len1 = WASM_VECTOR_LEN;
            getDataViewMemory0().setInt32(arg0 + 4 * 1, len1, true);
            getDataViewMemory0().setInt32(arg0 + 4 * 0, ptr1, true);
        },
        __wbg_debug_a4099fa12db6cd61: function(arg0) {
            console.debug(arg0);
        },
        __wbg_decodeAudioData_1816e469c0ce551d: function() { return handleError(function (arg0, arg1) {
            const ret = arg0.decodeAudioData(arg1);
            return ret;
        }, arguments); },
        __wbg_deleteBuffer_ab099883c168644d: function(arg0, arg1) {
            arg0.deleteBuffer(arg1);
        },
        __wbg_deleteFramebuffer_9738f3bb85c1ab35: function(arg0, arg1) {
            arg0.deleteFramebuffer(arg1);
        },
        __wbg_deleteProgram_9298fb3e3c1d3a78: function(arg0, arg1) {
            arg0.deleteProgram(arg1);
        },
        __wbg_deleteShader_aaf3b520a64d5d9d: function(arg0, arg1) {
            arg0.deleteShader(arg1);
        },
        __wbg_deleteTexture_9d411c0e60ffa324: function(arg0, arg1) {
            arg0.deleteTexture(arg1);
        },
        __wbg_deleteVertexArray_7bc7f92769862f93: function(arg0, arg1) {
            arg0.deleteVertexArray(arg1);
        },
        __wbg_depthFunc_f670d4cbb9cd0913: function(arg0, arg1) {
            arg0.depthFunc(arg1 >>> 0);
        },
        __wbg_depthMask_75a36d0065471a4b: function(arg0, arg1) {
            arg0.depthMask(arg1 !== 0);
        },
        __wbg_destination_97397bfc657d2f10: function(arg0) {
            const ret = arg0.destination;
            return ret;
        },
        __wbg_destination_a97dbc327ce97191: function(arg0) {
            const ret = arg0.destination;
            return ret;
        },
        __wbg_dirplayer_isFlashInstanceReady_c19f505d878f9f0f: function() { return handleError(function (arg0) {
            const ret = dirplayer_isFlashInstanceReady(arg0);
            return ret;
        }, arguments); },
        __wbg_dirplayer_isFlashLoading_a27a2d3e9df8232c: function() { return handleError(function () {
            const ret = dirplayer_isFlashLoading();
            return ret;
        }, arguments); },
        __wbg_dirplayer_ruffleCallFrame_0eb9fc9be93b2fe0: function(arg0, arg1) {
            dirplayer_ruffleCallFrame(arg0, arg1);
        },
        __wbg_dirplayer_ruffleCallFunction_cf315589b497822d: function() { return handleError(function (arg0, arg1, arg2, arg3, arg4) {
            const ret = dirplayer_ruffleCallFunction(arg0, getStringFromWasm0(arg1, arg2), getStringFromWasm0(arg3, arg4));
            return ret;
        }, arguments); },
        __wbg_dirplayer_ruffleCallFunction_f151ce21b1a6ef62: function() { return handleError(function (arg0, arg1, arg2, arg3, arg4) {
            const ret = dirplayer_ruffleCallFunction(arg0, getStringFromWasm0(arg1, arg2), getStringFromWasm0(arg3, arg4));
            return ret;
        }, arguments); },
        __wbg_dirplayer_ruffleDispatchMouse_4020e34d4eaae36b: function() { return handleError(function (arg0, arg1, arg2, arg3, arg4, arg5, arg6) {
            const ret = dirplayer_ruffleDispatchMouse(arg0, getStringFromWasm0(arg1, arg2), arg3, arg4, arg5, arg6);
            return ret;
        }, arguments); },
        __wbg_dirplayer_ruffleGetCurrentFrame_444076d4df2bcc4a: function(arg0) {
            const ret = dirplayer_ruffleGetCurrentFrame(arg0);
            return ret;
        },
        __wbg_dirplayer_ruffleGetCurrentFrame_cbf3d5ba65716ad6: function() { return handleError(function (arg0) {
            const ret = dirplayer_ruffleGetCurrentFrame(arg0);
            return ret;
        }, arguments); },
        __wbg_dirplayer_ruffleGetFlashProperty_14d69c764559a822: function() { return handleError(function (arg0, arg1, arg2, arg3) {
            const ret = dirplayer_ruffleGetFlashProperty(arg0, getStringFromWasm0(arg1, arg2), arg3);
            return ret;
        }, arguments); },
        __wbg_dirplayer_ruffleGetFrameCount_b7abf2aa13318851: function(arg0) {
            const ret = dirplayer_ruffleGetFrameCount(arg0);
            return ret;
        },
        __wbg_dirplayer_ruffleGetVariable_642630fdb93b8396: function() { return handleError(function (arg0, arg1, arg2) {
            const ret = dirplayer_ruffleGetVariable(arg0, getStringFromWasm0(arg1, arg2));
            return ret;
        }, arguments); },
        __wbg_dirplayer_ruffleGetVariable_7f09aa26c3fc1f4c: function() { return handleError(function (arg0, arg1, arg2) {
            const ret = dirplayer_ruffleGetVariable(arg0, getStringFromWasm0(arg1, arg2));
            return ret;
        }, arguments); },
        __wbg_dirplayer_ruffleGoToFrameAndStop_84815e01720de29e: function() { return handleError(function (arg0, arg1, arg2) {
            dirplayer_ruffleGoToFrameAndStop(arg0, getStringFromWasm0(arg1, arg2));
        }, arguments); },
        __wbg_dirplayer_ruffleGoToFrameAndStop_c0c10d1ce54455f7: function(arg0, arg1, arg2) {
            dirplayer_ruffleGoToFrameAndStop(arg0, getStringFromWasm0(arg1, arg2));
        },
        __wbg_dirplayer_ruffleGoToFrame_f993d92467780831: function(arg0, arg1, arg2) {
            dirplayer_ruffleGoToFrame(arg0, getStringFromWasm0(arg1, arg2));
        },
        __wbg_dirplayer_ruffleHitTest_e79fe42d520e451d: function(arg0, arg1, arg2) {
            const ret = dirplayer_ruffleHitTest(arg0, arg1, arg2);
            return ret;
        },
        __wbg_dirplayer_ruffleIsPlaying_c1822f4623eec3b8: function() { return handleError(function (arg0) {
            const ret = dirplayer_ruffleIsPlaying(arg0);
            return ret;
        }, arguments); },
        __wbg_dirplayer_ruffleIsPlaying_ffa0a68167006d13: function(arg0) {
            const ret = dirplayer_ruffleIsPlaying(arg0);
            return ret;
        },
        __wbg_dirplayer_rufflePlay_2062e26d4865d701: function(arg0) {
            dirplayer_rufflePlay(arg0);
        },
        __wbg_dirplayer_ruffleRewind_c967e086570fe4a5: function(arg0) {
            dirplayer_ruffleRewind(arg0);
        },
        __wbg_dirplayer_ruffleSetFlashProperty_fc6de61078b4d639: function(arg0, arg1, arg2, arg3, arg4, arg5) {
            dirplayer_ruffleSetFlashProperty(arg0, getStringFromWasm0(arg1, arg2), arg3, getStringFromWasm0(arg4, arg5));
        },
        __wbg_dirplayer_ruffleSetSize_463e05a25e73856d: function() { return handleError(function (arg0, arg1, arg2) {
            dirplayer_ruffleSetSize(arg0, arg1, arg2);
        }, arguments); },
        __wbg_dirplayer_ruffleSetVariable_08db8e8dadaebde0: function() { return handleError(function (arg0, arg1, arg2, arg3, arg4) {
            const ret = dirplayer_ruffleSetVariable(arg0, getStringFromWasm0(arg1, arg2), getStringFromWasm0(arg3, arg4));
            return ret;
        }, arguments); },
        __wbg_dirplayer_ruffleSetVariable_9e62c189e47e1bc2: function() { return handleError(function (arg0, arg1, arg2, arg3, arg4) {
            const ret = dirplayer_ruffleSetVariable(arg0, getStringFromWasm0(arg1, arg2), getStringFromWasm0(arg3, arg4));
            return ret;
        }, arguments); },
        __wbg_dirplayer_ruffleStop_a7726f984d164e0d: function(arg0) {
            dirplayer_ruffleStop(arg0);
        },
        __wbg_disableVertexAttribArray_24a020060006b10f: function(arg0, arg1) {
            arg0.disableVertexAttribArray(arg1 >>> 0);
        },
        __wbg_disable_7fe6fb3e97717f88: function(arg0, arg1) {
            arg0.disable(arg1 >>> 0);
        },
        __wbg_disconnect_7c1278d939bc7bb9: function() { return handleError(function (arg0) {
            arg0.disconnect();
        }, arguments); },
        __wbg_dispatchEvent_dc8dcc7ddca11378: function() { return handleError(function (arg0, arg1) {
            const ret = arg0.dispatchEvent(arg1);
            return ret;
        }, arguments); },
        __wbg_dispatchExternalXtraInstanceHandler_c000596c971ef447: function(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7) {
            const ret = dispatchExternalXtraInstanceHandler(getStringFromWasm0(arg1, arg2), arg3 >>> 0, getStringFromWasm0(arg4, arg5), getArrayU8FromWasm0(arg6, arg7));
            var ptr1 = isLikeNone(ret) ? 0 : passArray8ToWasm0(ret, wasm.__wbindgen_malloc);
            var len1 = WASM_VECTOR_LEN;
            getDataViewMemory0().setInt32(arg0 + 4 * 1, len1, true);
            getDataViewMemory0().setInt32(arg0 + 4 * 0, ptr1, true);
        },
        __wbg_dispatchExternalXtraStaticHandler_8c5198b26605ddb2: function(arg0, arg1, arg2, arg3, arg4, arg5, arg6) {
            const ret = dispatchExternalXtraStaticHandler(getStringFromWasm0(arg1, arg2), getStringFromWasm0(arg3, arg4), getArrayU8FromWasm0(arg5, arg6));
            var ptr1 = isLikeNone(ret) ? 0 : passArray8ToWasm0(ret, wasm.__wbindgen_malloc);
            var len1 = WASM_VECTOR_LEN;
            getDataViewMemory0().setInt32(arg0 + 4 * 1, len1, true);
            getDataViewMemory0().setInt32(arg0 + 4 * 0, ptr1, true);
        },
        __wbg_document_ee35a3d3ae34ef6c: function(arg0) {
            const ret = arg0.document;
            return isLikeNone(ret) ? 0 : addToExternrefTable0(ret);
        },
        __wbg_drawArrays_075228181299b824: function(arg0, arg1, arg2, arg3) {
            arg0.drawArrays(arg1 >>> 0, arg2, arg3);
        },
        __wbg_drawElements_ea2abffa9d1dc736: function(arg0, arg1, arg2, arg3, arg4) {
            arg0.drawElements(arg1 >>> 0, arg2, arg3 >>> 0, arg4);
        },
        __wbg_drawImage_a8b4c640211d95cb: function() { return handleError(function (arg0, arg1, arg2, arg3) {
            arg0.drawImage(arg1, arg2, arg3);
        }, arguments); },
        __wbg_drawingBufferHeight_662169c75ce2ac9b: function(arg0) {
            const ret = arg0.drawingBufferHeight;
            return ret;
        },
        __wbg_drawingBufferWidth_7c1bee4002a2ef59: function(arg0) {
            const ret = arg0.drawingBufferWidth;
            return ret;
        },
        __wbg_enableVertexAttribArray_475e06c31777296d: function(arg0, arg1) {
            arg0.enableVertexAttribArray(arg1 >>> 0);
        },
        __wbg_enable_d1ac04dfdd2fb3ae: function(arg0, arg1) {
            arg0.enable(arg1 >>> 0);
        },
        __wbg_entries_58c7934c745daac7: function(arg0) {
            const ret = Object.entries(arg0);
            return ret;
        },
        __wbg_error_7534b8e9a36f1ab4: function(arg0, arg1) {
            let deferred0_0;
            let deferred0_1;
            try {
                deferred0_0 = arg0;
                deferred0_1 = arg1;
                console.error(getStringFromWasm0(arg0, arg1));
            } finally {
                wasm.__wbindgen_free(deferred0_0, deferred0_1, 1);
            }
        },
        __wbg_error_9a7fe3f932034cde: function(arg0) {
            console.error(arg0);
        },
        __wbg_eval_3f0b9f0cbaf45a34: function() { return handleError(function (arg0, arg1) {
            const ret = eval(getStringFromWasm0(arg0, arg1));
            return ret;
        }, arguments); },
        __wbg_externalXtraHasStaticHandler_3ac3a31f9772f40d: function(arg0, arg1, arg2, arg3) {
            const ret = externalXtraHasStaticHandler(getStringFromWasm0(arg0, arg1), getStringFromWasm0(arg2, arg3));
            return ret;
        },
        __wbg_fetch_4f06ca81d87798ba: function(arg0, arg1, arg2) {
            const ret = arg0.fetch(getStringFromWasm0(arg1, arg2));
            return ret;
        },
        __wbg_fetch_e6e8e0a221783759: function(arg0, arg1) {
            const ret = arg0.fetch(arg1);
            return ret;
        },
        __wbg_fillRect_d44afec47e3a3fab: function(arg0, arg1, arg2, arg3, arg4) {
            arg0.fillRect(arg1, arg2, arg3, arg4);
        },
        __wbg_fillText_4a931850b976cc62: function() { return handleError(function (arg0, arg1, arg2, arg3, arg4) {
            arg0.fillText(getStringFromWasm0(arg1, arg2), arg3, arg4);
        }, arguments); },
        __wbg_firstChild_2950111f6da7246c: function(arg0) {
            const ret = arg0.firstChild;
            return isLikeNone(ret) ? 0 : addToExternrefTable0(ret);
        },
        __wbg_fontBoundingBoxAscent_8fb73ff8077ed0d7: function(arg0) {
            const ret = arg0.fontBoundingBoxAscent;
            return ret;
        },
        __wbg_fontBoundingBoxDescent_bc7ffeeee70da679: function(arg0) {
            const ret = arg0.fontBoundingBoxDescent;
            return ret;
        },
        __wbg_framebufferRenderbuffer_850811ed6e26475e: function(arg0, arg1, arg2, arg3, arg4) {
            arg0.framebufferRenderbuffer(arg1 >>> 0, arg2 >>> 0, arg3 >>> 0, arg4);
        },
        __wbg_framebufferTexture2D_c283e928186aa542: function(arg0, arg1, arg2, arg3, arg4, arg5) {
            arg0.framebufferTexture2D(arg1 >>> 0, arg2 >>> 0, arg3 >>> 0, arg4, arg5);
        },
        __wbg_fromEntries_7fb5bc874dbe50d5: function() { return handleError(function (arg0) {
            const ret = Object.fromEntries(arg0);
            return ret;
        }, arguments); },
        __wbg_from_bddd64e7d5ff6941: function(arg0) {
            const ret = Array.from(arg0);
            return ret;
        },
        __wbg_frontFace_d4a6507ad2939b5c: function(arg0, arg1) {
            arg0.frontFace(arg1 >>> 0);
        },
        __wbg_gain_9c9a2e054010f159: function(arg0) {
            const ret = arg0.gain;
            return ret;
        },
        __wbg_generateMipmap_5f9058c19cf7c6c1: function(arg0, arg1) {
            arg0.generateMipmap(arg1 >>> 0);
        },
        __wbg_getAttribLocation_7321cf2d67e036f6: function(arg0, arg1, arg2, arg3) {
            const ret = arg0.getAttribLocation(arg1, getStringFromWasm0(arg2, arg3));
            return ret;
        },
        __wbg_getAudioContext_27960e3362a00cf6: function() {
            const ret = window.getAudioContext();
            return ret;
        },
        __wbg_getContext_2a5764d48600bc43: function() { return handleError(function (arg0, arg1, arg2) {
            const ret = arg0.getContext(getStringFromWasm0(arg1, arg2));
            return isLikeNone(ret) ? 0 : addToExternrefTable0(ret);
        }, arguments); },
        __wbg_getContext_b28d2db7bd648242: function() { return handleError(function (arg0, arg1, arg2, arg3) {
            const ret = arg0.getContext(getStringFromWasm0(arg1, arg2), arg3);
            return isLikeNone(ret) ? 0 : addToExternrefTable0(ret);
        }, arguments); },
        __wbg_getDate_db46eca87d2b4907: function(arg0) {
            const ret = arg0.getDate();
            return ret;
        },
        __wbg_getExtension_3c0cb5ae01bb4b17: function() { return handleError(function (arg0, arg1, arg2) {
            const ret = arg0.getExtension(getStringFromWasm0(arg1, arg2));
            return isLikeNone(ret) ? 0 : addToExternrefTable0(ret);
        }, arguments); },
        __wbg_getFullYear_30ddf266b7612036: function(arg0) {
            const ret = arg0.getFullYear();
            return ret;
        },
        __wbg_getHours_e02e88722301c418: function(arg0) {
            const ret = arg0.getHours();
            return ret;
        },
        __wbg_getImageData_24d72830c218154d: function() { return handleError(function (arg0, arg1, arg2, arg3, arg4) {
            const ret = arg0.getImageData(arg1, arg2, arg3, arg4);
            return ret;
        }, arguments); },
        __wbg_getItem_0c792d344808dcf5: function() { return handleError(function (arg0, arg1, arg2, arg3) {
            const ret = arg1.getItem(getStringFromWasm0(arg2, arg3));
            var ptr1 = isLikeNone(ret) ? 0 : passStringToWasm0(ret, wasm.__wbindgen_malloc, wasm.__wbindgen_realloc);
            var len1 = WASM_VECTOR_LEN;
            getDataViewMemory0().setInt32(arg0 + 4 * 1, len1, true);
            getDataViewMemory0().setInt32(arg0 + 4 * 0, ptr1, true);
        }, arguments); },
        __wbg_getMinutes_eb73ceeb8231f6f4: function(arg0) {
            const ret = arg0.getMinutes();
            return ret;
        },
        __wbg_getMonth_4af888e76b42bb51: function(arg0) {
            const ret = arg0.getMonth();
            return ret;
        },
        __wbg_getProgramInfoLog_2ffa30e3abb8b5c2: function(arg0, arg1, arg2) {
            const ret = arg1.getProgramInfoLog(arg2);
            var ptr1 = isLikeNone(ret) ? 0 : passStringToWasm0(ret, wasm.__wbindgen_malloc, wasm.__wbindgen_realloc);
            var len1 = WASM_VECTOR_LEN;
            getDataViewMemory0().setInt32(arg0 + 4 * 1, len1, true);
            getDataViewMemory0().setInt32(arg0 + 4 * 0, ptr1, true);
        },
        __wbg_getProgramParameter_92e4540ca9da06b2: function(arg0, arg1, arg2) {
            const ret = arg0.getProgramParameter(arg1, arg2 >>> 0);
            return ret;
        },
        __wbg_getRandomValues_1c61fac11405ffdc: function() { return handleError(function (arg0, arg1) {
            globalThis.crypto.getRandomValues(getArrayU8FromWasm0(arg0, arg1));
        }, arguments); },
        __wbg_getRandomValues_c7e747eb57f43f2c: function() { return handleError(function (arg0, arg1, arg2) {
            const ret = arg0.getRandomValues(getArrayU8FromWasm0(arg1, arg2));
            return ret;
        }, arguments); },
        __wbg_getReader_804829cfb24eb4dd: function(arg0) {
            const ret = arg0.getReader();
            return ret;
        },
        __wbg_getSeconds_d5269a98a03bab5e: function(arg0) {
            const ret = arg0.getSeconds();
            return ret;
        },
        __wbg_getShaderInfoLog_9e0b96da4b13ae49: function(arg0, arg1, arg2) {
            const ret = arg1.getShaderInfoLog(arg2);
            var ptr1 = isLikeNone(ret) ? 0 : passStringToWasm0(ret, wasm.__wbindgen_malloc, wasm.__wbindgen_realloc);
            var len1 = WASM_VECTOR_LEN;
            getDataViewMemory0().setInt32(arg0 + 4 * 1, len1, true);
            getDataViewMemory0().setInt32(arg0 + 4 * 0, ptr1, true);
        },
        __wbg_getShaderParameter_afa4a3dd9dd397c1: function(arg0, arg1, arg2) {
            const ret = arg0.getShaderParameter(arg1, arg2 >>> 0);
            return ret;
        },
        __wbg_getTime_1e3cd1391c5c3995: function(arg0) {
            const ret = arg0.getTime();
            return ret;
        },
        __wbg_getTimezoneOffset_81776d10a4ec18a8: function(arg0) {
            const ret = arg0.getTimezoneOffset();
            return ret;
        },
        __wbg_getUniformLocation_d06b3a5b3c60e95c: function(arg0, arg1, arg2, arg3) {
            const ret = arg0.getUniformLocation(arg1, getStringFromWasm0(arg2, arg3));
            return isLikeNone(ret) ? 0 : addToExternrefTable0(ret);
        },
        __wbg_get_941633a1d2f510cb: function() { return handleError(function (arg0, arg1, arg2, arg3) {
            const ret = arg1.get(getStringFromWasm0(arg2, arg3));
            var ptr1 = isLikeNone(ret) ? 0 : passStringToWasm0(ret, wasm.__wbindgen_malloc, wasm.__wbindgen_realloc);
            var len1 = WASM_VECTOR_LEN;
            getDataViewMemory0().setInt32(arg0 + 4 * 1, len1, true);
            getDataViewMemory0().setInt32(arg0 + 4 * 0, ptr1, true);
        }, arguments); },
        __wbg_get_9b94d73e6221f75c: function(arg0, arg1) {
            const ret = arg0[arg1 >>> 0];
            return ret;
        },
        __wbg_get_b3ed3ad4be2bc8ac: function() { return handleError(function (arg0, arg1) {
            const ret = Reflect.get(arg0, arg1);
            return ret;
        }, arguments); },
        __wbg_groupCollapsed_717d39a5374aebde: function(arg0) {
            console.groupCollapsed(arg0);
        },
        __wbg_groupEnd_d32910da42d5599c: function() {
            console.groupEnd();
        },
        __wbg_hardwareConcurrency_f43f3888e9cb9177: function(arg0) {
            const ret = arg0.hardwareConcurrency;
            return ret;
        },
        __wbg_headers_59a2938db9f80985: function(arg0) {
            const ret = arg0.headers;
            return ret;
        },
        __wbg_height_38750dc6de41ee75: function(arg0) {
            const ret = arg0.height;
            return ret;
        },
        __wbg_height_87250db2be5164b9: function(arg0) {
            const ret = arg0.height;
            return ret;
        },
        __wbg_height_886e05c0c4a2fc0a: function() { return handleError(function (arg0) {
            const ret = arg0.height;
            return ret;
        }, arguments); },
        __wbg_height_aceb0c14551ea27d: function(arg0) {
            const ret = arg0.height;
            return ret;
        },
        __wbg_hidden_8ce6a98b8c12451c: function(arg0) {
            const ret = arg0.hidden;
            return ret;
        },
        __wbg_info_148d043840582012: function(arg0) {
            console.info(arg0);
        },
        __wbg_instanceof_ArrayBuffer_c367199e2fa2aa04: function(arg0) {
            let result;
            try {
                result = arg0 instanceof ArrayBuffer;
            } catch (_) {
                result = false;
            }
            const ret = result;
            return ret;
        },
        __wbg_instanceof_Blob_ce92a9ddd729a84a: function(arg0) {
            let result;
            try {
                result = arg0 instanceof Blob;
            } catch (_) {
                result = false;
            }
            const ret = result;
            return ret;
        },
        __wbg_instanceof_CanvasRenderingContext2d_4bb052fd1c3d134d: function(arg0) {
            let result;
            try {
                result = arg0 instanceof CanvasRenderingContext2D;
            } catch (_) {
                result = false;
            }
            const ret = result;
            return ret;
        },
        __wbg_instanceof_Date_1b9f15b87f10aa4c: function(arg0) {
            let result;
            try {
                result = arg0 instanceof Date;
            } catch (_) {
                result = false;
            }
            const ret = result;
            return ret;
        },
        __wbg_instanceof_HtmlCanvasElement_3f2f6e1edb1c9792: function(arg0) {
            let result;
            try {
                result = arg0 instanceof HTMLCanvasElement;
            } catch (_) {
                result = false;
            }
            const ret = result;
            return ret;
        },
        __wbg_instanceof_HtmlElement_5abfac207260fd6f: function(arg0) {
            let result;
            try {
                result = arg0 instanceof HTMLElement;
            } catch (_) {
                result = false;
            }
            const ret = result;
            return ret;
        },
        __wbg_instanceof_ImageBitmap_ac19b1b37fd818f6: function(arg0) {
            let result;
            try {
                result = arg0 instanceof ImageBitmap;
            } catch (_) {
                result = false;
            }
            const ret = result;
            return ret;
        },
        __wbg_instanceof_ReadableStreamDefaultReader_8c3866331ce32722: function(arg0) {
            let result;
            try {
                result = arg0 instanceof ReadableStreamDefaultReader;
            } catch (_) {
                result = false;
            }
            const ret = result;
            return ret;
        },
        __wbg_instanceof_Response_ee1d54d79ae41977: function(arg0) {
            let result;
            try {
                result = arg0 instanceof Response;
            } catch (_) {
                result = false;
            }
            const ret = result;
            return ret;
        },
        __wbg_instanceof_WebGl2RenderingContext_4a08a94517ed5240: function(arg0) {
            let result;
            try {
                result = arg0 instanceof WebGL2RenderingContext;
            } catch (_) {
                result = false;
            }
            const ret = result;
            return ret;
        },
        __wbg_instanceof_Window_ed49b2db8df90359: function(arg0) {
            let result;
            try {
                result = arg0 instanceof Window;
            } catch (_) {
                result = false;
            }
            const ret = result;
            return ret;
        },
        __wbg_isArray_d314bb98fcf08331: function(arg0) {
            const ret = Array.isArray(arg0);
            return ret;
        },
        __wbg_keys_b50a709a76add04e: function(arg0) {
            const ret = Object.keys(arg0);
            return ret;
        },
        __wbg_language_71bb354dd789d4d4: function(arg0, arg1) {
            const ret = arg1.language;
            var ptr1 = isLikeNone(ret) ? 0 : passStringToWasm0(ret, wasm.__wbindgen_malloc, wasm.__wbindgen_realloc);
            var len1 = WASM_VECTOR_LEN;
            getDataViewMemory0().setInt32(arg0 + 4 * 1, len1, true);
            getDataViewMemory0().setInt32(arg0 + 4 * 0, ptr1, true);
        },
        __wbg_length_32ed9a279acd054c: function(arg0) {
            const ret = arg0.length;
            return ret;
        },
        __wbg_length_35a7bace40f36eac: function(arg0) {
            const ret = arg0.length;
            return ret;
        },
        __wbg_length_900cc5c458bae2dc: function(arg0) {
            const ret = arg0.length;
            return ret;
        },
        __wbg_lineTo_c584cff6c760c4a5: function(arg0, arg1, arg2) {
            arg0.lineTo(arg1, arg2);
        },
        __wbg_linkProgram_6600dd2c0863bbfd: function(arg0, arg1) {
            arg0.linkProgram(arg1);
        },
        __wbg_localStorage_a22d31b9eacc4594: function() { return handleError(function (arg0) {
            const ret = arg0.localStorage;
            return isLikeNone(ret) ? 0 : addToExternrefTable0(ret);
        }, arguments); },
        __wbg_location_df7ca06c93e51763: function(arg0) {
            const ret = arg0.location;
            return ret;
        },
        __wbg_log_6b5ca2e6124b2808: function(arg0) {
            console.log(arg0);
        },
        __wbg_measureText_9d64a92333bd05ee: function() { return handleError(function (arg0, arg1, arg2) {
            const ret = arg0.measureText(getStringFromWasm0(arg1, arg2));
            return ret;
        }, arguments); },
        __wbg_moveTo_e9190fc700d55b40: function(arg0, arg1, arg2) {
            arg0.moveTo(arg1, arg2);
        },
        __wbg_navigator_43be698ba96fc088: function(arg0) {
            const ret = arg0.navigator;
            return ret;
        },
        __wbg_new_057993d5b5e07835: function() { return handleError(function (arg0, arg1) {
            const ret = new WebSocket(getStringFromWasm0(arg0, arg1));
            return ret;
        }, arguments); },
        __wbg_new_0_73afc35eb544e539: function() {
            const ret = new Date();
            return ret;
        },
        __wbg_new_245cd5c49157e602: function(arg0) {
            const ret = new Date(arg0);
            return ret;
        },
        __wbg_new_361308b2356cecd0: function() {
            const ret = new Object();
            return ret;
        },
        __wbg_new_3eb36ae241fe6f44: function() {
            const ret = new Array();
            return ret;
        },
        __wbg_new_64284bd487f9d239: function() { return handleError(function () {
            const ret = new Headers();
            return ret;
        }, arguments); },
        __wbg_new_738c2e238e869a5e: function() { return handleError(function () {
            const ret = new FormData();
            return ret;
        }, arguments); },
        __wbg_new_8a6f238a6ece86ea: function() {
            const ret = new Error();
            return ret;
        },
        __wbg_new_b5d9e2fb389fef91: function(arg0, arg1) {
            try {
                var state0 = {a: arg0, b: arg1};
                var cb0 = (arg0, arg1) => {
                    const a = state0.a;
                    state0.a = 0;
                    try {
                        return wasm_bindgen_89cb8f197c2bd7a9___convert__closures_____invoke___wasm_bindgen_89cb8f197c2bd7a9___JsValue__wasm_bindgen_89cb8f197c2bd7a9___JsValue_____(a, state0.b, arg0, arg1);
                    } finally {
                        state0.a = a;
                    }
                };
                const ret = new Promise(cb0);
                return ret;
            } finally {
                state0.a = state0.b = 0;
            }
        },
        __wbg_new_dca287b076112a51: function() {
            const ret = new Map();
            return ret;
        },
        __wbg_new_dd2b680c8bf6ae29: function(arg0) {
            const ret = new Uint8Array(arg0);
            return ret;
        },
        __wbg_new_from_slice_a3d2629dc1826784: function(arg0, arg1) {
            const ret = new Uint8Array(getArrayU8FromWasm0(arg0, arg1));
            return ret;
        },
        __wbg_new_no_args_1c7c842f08d00ebb: function(arg0, arg1) {
            const ret = new Function(getStringFromWasm0(arg0, arg1));
            return ret;
        },
        __wbg_new_with_buffer_source_sequence_and_options_60e4700b934de2bb: function() { return handleError(function (arg0, arg1) {
            const ret = new Blob(arg0, arg1);
            return ret;
        }, arguments); },
        __wbg_new_with_event_init_dict_48877e7ca125f3c1: function() { return handleError(function (arg0, arg1, arg2) {
            const ret = new CustomEvent(getStringFromWasm0(arg0, arg1), arg2);
            return ret;
        }, arguments); },
        __wbg_new_with_length_a2c39cbe88fd8ff1: function(arg0) {
            const ret = new Uint8Array(arg0 >>> 0);
            return ret;
        },
        __wbg_new_with_number_of_channels_and_length_and_sample_rate_af11659331cdca6f: function() { return handleError(function (arg0, arg1, arg2) {
            const ret = new lOfflineAudioContext(arg0 >>> 0, arg1 >>> 0, arg2);
            return ret;
        }, arguments); },
        __wbg_new_with_opt_blob_6f679893da99d7b9: function() { return handleError(function (arg0) {
            const ret = new Response(arg0);
            return ret;
        }, arguments); },
        __wbg_new_with_str_a7c7f835549b152a: function() { return handleError(function (arg0, arg1) {
            const ret = new Request(getStringFromWasm0(arg0, arg1));
            return ret;
        }, arguments); },
        __wbg_new_with_str_and_init_a61cbc6bdef21614: function() { return handleError(function (arg0, arg1, arg2) {
            const ret = new Request(getStringFromWasm0(arg0, arg1), arg2);
            return ret;
        }, arguments); },
        __wbg_new_with_u8_clamped_array_and_sh_0c0b789ceb2eab31: function() { return handleError(function (arg0, arg1, arg2, arg3) {
            const ret = new ImageData(getClampedArrayU8FromWasm0(arg0, arg1), arg2 >>> 0, arg3 >>> 0);
            return ret;
        }, arguments); },
        __wbg_new_with_year_month_day_hr_min_sec_f82362c71c4dfc23: function(arg0, arg1, arg2, arg3, arg4, arg5) {
            const ret = new Date(arg0 >>> 0, arg1, arg2, arg3, arg4, arg5);
            return ret;
        },
        __wbg_now_a3af9a2f4bbaa4d1: function() {
            const ret = Date.now();
            return ret;
        },
        __wbg_now_ebffdf7e580f210d: function(arg0) {
            const ret = arg0.now();
            return ret;
        },
        __wbg_numberOfChannels_ec1aad80a2939fa1: function(arg0) {
            const ret = arg0.numberOfChannels;
            return ret;
        },
        __wbg_of_9ab14f9d4bfb5040: function(arg0, arg1) {
            const ret = Array.of(arg0, arg1);
            return ret;
        },
        __wbg_of_f915f7cd925b21a5: function(arg0) {
            const ret = Array.of(arg0);
            return ret;
        },
        __wbg_ok_87f537440a0acf85: function(arg0) {
            const ret = arg0.ok;
            return ret;
        },
        __wbg_onBreakpointListChanged_45ef7b459ae799a6: function(arg0, arg1) {
            var v0 = getArrayJsValueFromWasm0(arg0, arg1).slice();
            wasm.__wbindgen_free(arg0, arg1 * 4, 4);
            onBreakpointListChanged(v0);
        },
        __wbg_onCastLibNameChanged_1a48ce7ada4f497e: function(arg0, arg1, arg2) {
            onCastLibNameChanged(arg0 >>> 0, getStringFromWasm0(arg1, arg2));
        },
        __wbg_onCastMemberListChanged_133c5d213c405bbb: function(arg0, arg1) {
            onCastMemberListChanged(arg0 >>> 0, arg1);
        },
        __wbg_onChannelDisplayNameChanged_3433ab2abb555603: function(arg0, arg1, arg2) {
            onChannelDisplayNameChanged(arg0, getStringFromWasm0(arg1, arg2));
        },
        __wbg_onClearTimeout_d78e85ffadc8941b: function(arg0, arg1) {
            onClearTimeout(getStringFromWasm0(arg0, arg1));
        },
        __wbg_onDatumSnapshot_cf0e789e2d401753: function(arg0, arg1) {
            onDatumSnapshot(arg0 >>> 0, arg1);
        },
        __wbg_onDebugMessage_40487a73e4f9768b: function(arg0, arg1) {
            onDebugMessage(getStringFromWasm0(arg0, arg1));
        },
        __wbg_onExternalEvent_2e9bc140e0c0a3fb: function(arg0, arg1) {
            onExternalEvent(getStringFromWasm0(arg0, arg1));
        },
        __wbg_onFlashMemberLoaded_f6f73b47c3400581: function(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8) {
            onFlashMemberLoaded(arg0, arg1, arg2, getArrayU8FromWasm0(arg3, arg4), arg5 >>> 0, arg6 >>> 0, arg7 !== 0, arg8);
        },
        __wbg_onFrameChanged_359c496ef260b106: function(arg0) {
            onFrameChanged(arg0 >>> 0);
        },
        __wbg_onMovieLoadFailed_44adbe687bd0045d: function(arg0, arg1, arg2, arg3) {
            onMovieLoadFailed(getStringFromWasm0(arg0, arg1), getStringFromWasm0(arg2, arg3));
        },
        __wbg_onMovieLoaded_59006cc6a8df79dd: function(arg0) {
            onMovieLoaded(OnMovieLoadedCallbackData.__wrap(arg0));
        },
        __wbg_onRequestXtraLoad_6be1058b9ec9c171: function(arg0, arg1) {
            onRequestXtraLoad(getStringFromWasm0(arg0, arg1));
        },
        __wbg_onScheduleTimeout_537d3a90a324a7db: function(arg0, arg1, arg2) {
            onScheduleTimeout(getStringFromWasm0(arg0, arg1), arg2 >>> 0);
        },
        __wbg_onScopeListChanged_a3e2e1f81c1d3a6f: function(arg0, arg1) {
            var v0 = getArrayJsValueFromWasm0(arg0, arg1).slice();
            wasm.__wbindgen_free(arg0, arg1 * 4, 4);
            onScopeListChanged(v0);
        },
        __wbg_onScriptInstanceSnapshot_a6b76c6dfb28d785: function(arg0, arg1) {
            onScriptInstanceSnapshot(arg0 >>> 0, arg1);
        },
        __wbg_onStageSizeChanged_1351bef4d27a718d: function(arg0, arg1, arg2) {
            onStageSizeChanged(arg0 >>> 0, arg1 >>> 0, arg2 !== 0);
        },
        __wbg_open_ea44acde696d3b0c: function() { return handleError(function (arg0, arg1, arg2, arg3, arg4) {
            const ret = arg0.open(getStringFromWasm0(arg1, arg2), getStringFromWasm0(arg3, arg4));
            return isLikeNone(ret) ? 0 : addToExternrefTable0(ret);
        }, arguments); },
        __wbg_pan_835990e58cdbbfde: function(arg0) {
            const ret = arg0.pan;
            return ret;
        },
        __wbg_parentNode_d44bd5ec58601e45: function(arg0) {
            const ret = arg0.parentNode;
            return isLikeNone(ret) ? 0 : addToExternrefTable0(ret);
        },
        __wbg_parse_708461a1feddfb38: function() { return handleError(function (arg0, arg1) {
            const ret = JSON.parse(getStringFromWasm0(arg0, arg1));
            return ret;
        }, arguments); },
        __wbg_performance_06f12ba62483475d: function(arg0) {
            const ret = arg0.performance;
            return isLikeNone(ret) ? 0 : addToExternrefTable0(ret);
        },
        __wbg_pixelDepth_587f1f470fe1fb00: function() { return handleError(function (arg0) {
            const ret = arg0.pixelDepth;
            return ret;
        }, arguments); },
        __wbg_pixelStorei_2a65936c11b710fe: function(arg0, arg1, arg2) {
            arg0.pixelStorei(arg1 >>> 0, arg2);
        },
        __wbg_polygonOffset_4b3158d8ed028862: function(arg0, arg1, arg2) {
            arg0.polygonOffset(arg1, arg2);
        },
        __wbg_preventDefault_cdcfcd7e301b9702: function(arg0) {
            arg0.preventDefault();
        },
        __wbg_protocol_4c3b13957de7d079: function() { return handleError(function (arg0, arg1) {
            const ret = arg1.protocol;
            const ptr1 = passStringToWasm0(ret, wasm.__wbindgen_malloc, wasm.__wbindgen_realloc);
            const len1 = WASM_VECTOR_LEN;
            getDataViewMemory0().setInt32(arg0 + 4 * 1, len1, true);
            getDataViewMemory0().setInt32(arg0 + 4 * 0, ptr1, true);
        }, arguments); },
        __wbg_prototypesetcall_bdcdcc5842e4d77d: function(arg0, arg1, arg2) {
            Uint8Array.prototype.set.call(getArrayU8FromWasm0(arg0, arg1), arg2);
        },
        __wbg_push_8ffdcb2063340ba5: function(arg0, arg1) {
            const ret = arg0.push(arg1);
            return ret;
        },
        __wbg_putImageData_78318465ad96c2c3: function() { return handleError(function (arg0, arg1, arg2, arg3) {
            arg0.putImageData(arg1, arg2, arg3);
        }, arguments); },
        __wbg_querySelector_c3b0df2d58eec220: function() { return handleError(function (arg0, arg1, arg2) {
            const ret = arg0.querySelector(getStringFromWasm0(arg1, arg2));
            return isLikeNone(ret) ? 0 : addToExternrefTable0(ret);
        }, arguments); },
        __wbg_queueMicrotask_0aa0a927f78f5d98: function(arg0) {
            const ret = arg0.queueMicrotask;
            return ret;
        },
        __wbg_queueMicrotask_5bb536982f78a56f: function(arg0) {
            queueMicrotask(arg0);
        },
        __wbg_readPixels_c68653ffa418f3cb: function() { return handleError(function (arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8) {
            arg0.readPixels(arg1, arg2, arg3, arg4, arg5 >>> 0, arg6 >>> 0, arg7 === 0 ? undefined : getArrayU8FromWasm0(arg7, arg8));
        }, arguments); },
        __wbg_read_68fd377df67e19b0: function(arg0) {
            const ret = arg0.read();
            return ret;
        },
        __wbg_readyState_1bb73ec7b8a54656: function(arg0) {
            const ret = arg0.readyState;
            return ret;
        },
        __wbg_reason_35fce8e55dd90f31: function(arg0, arg1) {
            const ret = arg1.reason;
            const ptr1 = passStringToWasm0(ret, wasm.__wbindgen_malloc, wasm.__wbindgen_realloc);
            const len1 = WASM_VECTOR_LEN;
            getDataViewMemory0().setInt32(arg0 + 4 * 1, len1, true);
            getDataViewMemory0().setInt32(arg0 + 4 * 0, ptr1, true);
        },
        __wbg_removeChild_2f0b06213dbc49ca: function() { return handleError(function (arg0, arg1) {
            const ret = arg0.removeChild(arg1);
            return ret;
        }, arguments); },
        __wbg_removeProperty_a0d2ff8a76ffd2b1: function() { return handleError(function (arg0, arg1, arg2, arg3) {
            const ret = arg1.removeProperty(getStringFromWasm0(arg2, arg3));
            const ptr1 = passStringToWasm0(ret, wasm.__wbindgen_malloc, wasm.__wbindgen_realloc);
            const len1 = WASM_VECTOR_LEN;
            getDataViewMemory0().setInt32(arg0 + 4 * 1, len1, true);
            getDataViewMemory0().setInt32(arg0 + 4 * 0, ptr1, true);
        }, arguments); },
        __wbg_remove_31c39325eee968fc: function(arg0) {
            arg0.remove();
        },
        __wbg_renderbufferStorage_1bc02383614b76b2: function(arg0, arg1, arg2, arg3, arg4) {
            arg0.renderbufferStorage(arg1 >>> 0, arg2 >>> 0, arg3, arg4);
        },
        __wbg_requestAnimationFrame_43682f8e1c5e5348: function() { return handleError(function (arg0, arg1) {
            const ret = arg0.requestAnimationFrame(arg1);
            return ret;
        }, arguments); },
        __wbg_resolve_002c4b7d9d8f6b64: function(arg0) {
            const ret = Promise.resolve(arg0);
            return ret;
        },
        __wbg_resume_7995ba29b6bb4edb: function() { return handleError(function (arg0) {
            const ret = arg0.resume();
            return ret;
        }, arguments); },
        __wbg_revokeObjectURL_ba5712ef5af8bc9a: function() { return handleError(function (arg0, arg1) {
            URL.revokeObjectURL(getStringFromWasm0(arg0, arg1));
        }, arguments); },
        __wbg_sampleRate_4df44cabc0711e23: function(arg0) {
            const ret = arg0.sampleRate;
            return ret;
        },
        __wbg_sampleRate_8142bbf3840b654b: function(arg0) {
            const ret = arg0.sampleRate;
            return ret;
        },
        __wbg_scale_543277ecf8cf836b: function() { return handleError(function (arg0, arg1, arg2) {
            arg0.scale(arg1, arg2);
        }, arguments); },
        __wbg_scissor_2ff8f18f05a6d408: function(arg0, arg1, arg2, arg3, arg4) {
            arg0.scissor(arg1, arg2, arg3, arg4);
        },
        __wbg_screen_a85b45d71d93a9fc: function() { return handleError(function (arg0) {
            const ret = arg0.screen;
            return ret;
        }, arguments); },
        __wbg_send_542f95dea2df7994: function() { return handleError(function (arg0, arg1, arg2) {
            arg0.send(getArrayU8FromWasm0(arg1, arg2));
        }, arguments); },
        __wbg_setAttribute_cc8e4c8a2a008508: function() { return handleError(function (arg0, arg1, arg2, arg3, arg4) {
            arg0.setAttribute(getStringFromWasm0(arg1, arg2), getStringFromWasm0(arg3, arg4));
        }, arguments); },
        __wbg_setDate_6d7cf6c9745a80d7: function(arg0, arg1) {
            const ret = arg0.setDate(arg1 >>> 0);
            return ret;
        },
        __wbg_setFullYear_9cbf8e19711cd8e5: function(arg0, arg1) {
            const ret = arg0.setFullYear(arg1 >>> 0);
            return ret;
        },
        __wbg_setHours_0e1054f1661a6e86: function(arg0, arg1) {
            const ret = arg0.setHours(arg1 >>> 0);
            return ret;
        },
        __wbg_setItem_cf340bb2edbd3089: function() { return handleError(function (arg0, arg1, arg2, arg3, arg4) {
            arg0.setItem(getStringFromWasm0(arg1, arg2), getStringFromWasm0(arg3, arg4));
        }, arguments); },
        __wbg_setMilliseconds_999480b472f30a93: function(arg0, arg1) {
            const ret = arg0.setMilliseconds(arg1 >>> 0);
            return ret;
        },
        __wbg_setMinutes_3849c7afb7d892bb: function(arg0, arg1) {
            const ret = arg0.setMinutes(arg1 >>> 0);
            return ret;
        },
        __wbg_setMonth_6c5c7c9c040c4cfb: function(arg0, arg1) {
            const ret = arg0.setMonth(arg1 >>> 0);
            return ret;
        },
        __wbg_setProperty_cbb25c4e74285b39: function() { return handleError(function (arg0, arg1, arg2, arg3, arg4) {
            arg0.setProperty(getStringFromWasm0(arg1, arg2), getStringFromWasm0(arg3, arg4));
        }, arguments); },
        __wbg_setSeconds_6749903a358be7da: function(arg0, arg1) {
            const ret = arg0.setSeconds(arg1 >>> 0);
            return ret;
        },
        __wbg_setTimeout_db2dbaeefb6f39c7: function() { return handleError(function (arg0, arg1) {
            const ret = setTimeout(arg0, arg1);
            return ret;
        }, arguments); },
        __wbg_set_1eb0999cf5d27fc8: function(arg0, arg1, arg2) {
            const ret = arg0.set(arg1, arg2);
            return ret;
        },
        __wbg_set_6cb8631f80447a67: function() { return handleError(function (arg0, arg1, arg2) {
            const ret = Reflect.set(arg0, arg1, arg2);
            return ret;
        }, arguments); },
        __wbg_set_alpha_aa518f0583d53bfe: function(arg0, arg1) {
            arg0.alpha = arg1 !== 0;
        },
        __wbg_set_binaryType_5bbf62e9f705dc1a: function(arg0, arg1) {
            arg0.binaryType = __wbindgen_enum_BinaryType[arg1];
        },
        __wbg_set_body_9a7e00afe3cfe244: function(arg0, arg1) {
            arg0.body = arg1;
        },
        __wbg_set_buffer_730f06ef4e703eef: function(arg0, arg1) {
            arg0.buffer = arg1;
        },
        __wbg_set_cc56eefd2dd91957: function(arg0, arg1, arg2) {
            arg0.set(getArrayU8FromWasm0(arg1, arg2));
        },
        __wbg_set_db769d02949a271d: function() { return handleError(function (arg0, arg1, arg2, arg3, arg4) {
            arg0.set(getStringFromWasm0(arg1, arg2), getStringFromWasm0(arg3, arg4));
        }, arguments); },
        __wbg_set_depth_112554f422895a0c: function(arg0, arg1) {
            arg0.depth = arg1 !== 0;
        },
        __wbg_set_detail_fa3b358526be3a85: function(arg0, arg1) {
            arg0.detail = arg1;
        },
        __wbg_set_fillStyle_4c9682826c3e231a: function(arg0, arg1) {
            arg0.fillStyle = arg1;
        },
        __wbg_set_fillStyle_783d3f7489475421: function(arg0, arg1, arg2) {
            arg0.fillStyle = getStringFromWasm0(arg1, arg2);
        },
        __wbg_set_font_575685c8f7e56957: function(arg0, arg1, arg2) {
            arg0.font = getStringFromWasm0(arg1, arg2);
        },
        __wbg_set_headers_cfc5f4b2c1f20549: function(arg0, arg1) {
            arg0.headers = arg1;
        },
        __wbg_set_height_f21f985387070100: function(arg0, arg1) {
            arg0.height = arg1 >>> 0;
        },
        __wbg_set_imageSmoothingEnabled_85c30565ebbfba4f: function(arg0, arg1) {
            arg0.imageSmoothingEnabled = arg1 !== 0;
        },
        __wbg_set_loopEnd_e6b8ccf6a1c6ab77: function(arg0, arg1) {
            arg0.loopEnd = arg1;
        },
        __wbg_set_loopStart_ec230e89c9f8546a: function(arg0, arg1) {
            arg0.loopStart = arg1;
        },
        __wbg_set_loop_2b614794e728ae0c: function(arg0, arg1) {
            arg0.loop = arg1 !== 0;
        },
        __wbg_set_method_c3e20375f5ae7fac: function(arg0, arg1, arg2) {
            arg0.method = getStringFromWasm0(arg1, arg2);
        },
        __wbg_set_mode_b13642c312648202: function(arg0, arg1) {
            arg0.mode = __wbindgen_enum_RequestMode[arg1];
        },
        __wbg_set_onclose_d382f3e2c2b850eb: function(arg0, arg1) {
            arg0.onclose = arg1;
        },
        __wbg_set_onerror_377f18bf4569bf85: function(arg0, arg1) {
            arg0.onerror = arg1;
        },
        __wbg_set_onmessage_2114aa5f4f53051e: function(arg0, arg1) {
            arg0.onmessage = arg1;
        },
        __wbg_set_onopen_b7b52d519d6c0f11: function(arg0, arg1) {
            arg0.onopen = arg1;
        },
        __wbg_set_preserve_drawing_buffer_c0333ecf127fea53: function(arg0, arg1) {
            arg0.preserveDrawingBuffer = arg1 !== 0;
        },
        __wbg_set_strokeStyle_087121ed5350b038: function(arg0, arg1, arg2) {
            arg0.strokeStyle = getStringFromWasm0(arg1, arg2);
        },
        __wbg_set_textBaseline_c7ec6538cc52b073: function(arg0, arg1, arg2) {
            arg0.textBaseline = getStringFromWasm0(arg1, arg2);
        },
        __wbg_set_type_148de20768639245: function(arg0, arg1, arg2) {
            arg0.type = getStringFromWasm0(arg1, arg2);
        },
        __wbg_set_value_c51b9eb4cf70aa54: function(arg0, arg1) {
            arg0.value = arg1;
        },
        __wbg_set_width_d60bc4f2f20c56a4: function(arg0, arg1) {
            arg0.width = arg1 >>> 0;
        },
        __wbg_shaderSource_32425cfe6e5a1e52: function(arg0, arg1, arg2, arg3) {
            arg0.shaderSource(arg1, getStringFromWasm0(arg2, arg3));
        },
        __wbg_stack_0ed75d68575b0f3c: function(arg0, arg1) {
            const ret = arg1.stack;
            const ptr1 = passStringToWasm0(ret, wasm.__wbindgen_malloc, wasm.__wbindgen_realloc);
            const len1 = WASM_VECTOR_LEN;
            getDataViewMemory0().setInt32(arg0 + 4 * 1, len1, true);
            getDataViewMemory0().setInt32(arg0 + 4 * 0, ptr1, true);
        },
        __wbg_startRendering_1c95d1498a8fa12c: function() { return handleError(function (arg0) {
            const ret = arg0.startRendering();
            return ret;
        }, arguments); },
        __wbg_start_03319096e5823c33: function() { return handleError(function (arg0, arg1, arg2, arg3) {
            arg0.start(arg1, arg2, arg3);
        }, arguments); },
        __wbg_start_188ac6363145167c: function() { return handleError(function (arg0) {
            arg0.start();
        }, arguments); },
        __wbg_start_4482394d0e94eb2a: function() { return handleError(function (arg0, arg1, arg2) {
            arg0.start(arg1, arg2);
        }, arguments); },
        __wbg_state_1bcd7483badf9570: function(arg0) {
            const ret = arg0.state;
            return (__wbindgen_enum_AudioContextState.indexOf(ret) + 1 || 4) - 1;
        },
        __wbg_static_accessor_GLOBAL_12837167ad935116: function() {
            const ret = typeof global === 'undefined' ? null : global;
            return isLikeNone(ret) ? 0 : addToExternrefTable0(ret);
        },
        __wbg_static_accessor_GLOBAL_THIS_e628e89ab3b1c95f: function() {
            const ret = typeof globalThis === 'undefined' ? null : globalThis;
            return isLikeNone(ret) ? 0 : addToExternrefTable0(ret);
        },
        __wbg_static_accessor_SELF_a621d3dfbb60d0ce: function() {
            const ret = typeof self === 'undefined' ? null : self;
            return isLikeNone(ret) ? 0 : addToExternrefTable0(ret);
        },
        __wbg_static_accessor_WINDOW_f8727f0cf888e0bd: function() {
            const ret = typeof window === 'undefined' ? null : window;
            return isLikeNone(ret) ? 0 : addToExternrefTable0(ret);
        },
        __wbg_status_89d7e803db911ee7: function(arg0) {
            const ret = arg0.status;
            return ret;
        },
        __wbg_stop_6fc487a417669238: function() { return handleError(function (arg0, arg1) {
            arg0.stop(arg1);
        }, arguments); },
        __wbg_stroke_240ea7f2407d73c0: function(arg0) {
            arg0.stroke();
        },
        __wbg_style_0b7c9bd318f8b807: function(arg0) {
            const ret = arg0.style;
            return ret;
        },
        __wbg_suspend_9b7e813b607b7796: function() { return handleError(function (arg0) {
            const ret = arg0.suspend();
            return ret;
        }, arguments); },
        __wbg_texImage2D_c1bb39f4b3a26e90: function() { return handleError(function (arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10) {
            arg0.texImage2D(arg1 >>> 0, arg2, arg3, arg4, arg5, arg6, arg7 >>> 0, arg8 >>> 0, arg9 === 0 ? undefined : getArrayU8FromWasm0(arg9, arg10));
        }, arguments); },
        __wbg_texParameterf_54692407e8857e13: function(arg0, arg1, arg2, arg3) {
            arg0.texParameterf(arg1 >>> 0, arg2 >>> 0, arg3);
        },
        __wbg_texParameteri_0d45be2c88d6bad8: function(arg0, arg1, arg2, arg3) {
            arg0.texParameteri(arg1 >>> 0, arg2 >>> 0, arg3);
        },
        __wbg_then_0d9fe2c7b1857d32: function(arg0, arg1, arg2) {
            const ret = arg0.then(arg1, arg2);
            return ret;
        },
        __wbg_then_b9e7b3b5f1a9e1b5: function(arg0, arg1) {
            const ret = arg0.then(arg1);
            return ret;
        },
        __wbg_toLocaleDateString_a3ef04bcff0c4522: function(arg0, arg1, arg2, arg3) {
            const ret = arg0.toLocaleDateString(getStringFromWasm0(arg1, arg2), arg3);
            return ret;
        },
        __wbg_toLocaleTimeString_8bfbeb434619e33f: function(arg0, arg1, arg2, arg3) {
            const ret = arg0.toLocaleTimeString(getStringFromWasm0(arg1, arg2), arg3);
            return ret;
        },
        __wbg_translate_3aa10730376a8c06: function() { return handleError(function (arg0, arg1, arg2) {
            arg0.translate(arg1, arg2);
        }, arguments); },
        __wbg_uniform1f_b500ede5b612bea2: function(arg0, arg1, arg2) {
            arg0.uniform1f(arg1, arg2);
        },
        __wbg_uniform1fv_40991bd25d4fcc43: function(arg0, arg1, arg2, arg3) {
            arg0.uniform1fv(arg1, getArrayF32FromWasm0(arg2, arg3));
        },
        __wbg_uniform1i_e9aee4b9e7fe8c4b: function(arg0, arg1, arg2) {
            arg0.uniform1i(arg1, arg2);
        },
        __wbg_uniform1iv_46f426ec78e6d7fe: function(arg0, arg1, arg2, arg3) {
            arg0.uniform1iv(arg1, getArrayI32FromWasm0(arg2, arg3));
        },
        __wbg_uniform2f_1887b1268f65bfee: function(arg0, arg1, arg2, arg3) {
            arg0.uniform2f(arg1, arg2, arg3);
        },
        __wbg_uniform3f_63423ab60240d227: function(arg0, arg1, arg2, arg3, arg4) {
            arg0.uniform3f(arg1, arg2, arg3, arg4);
        },
        __wbg_uniform3fv_c0872003729939a5: function(arg0, arg1, arg2, arg3) {
            arg0.uniform3fv(arg1, getArrayF32FromWasm0(arg2, arg3));
        },
        __wbg_uniform4f_f6b5e2024636033a: function(arg0, arg1, arg2, arg3, arg4, arg5) {
            arg0.uniform4f(arg1, arg2, arg3, arg4, arg5);
        },
        __wbg_uniformMatrix4fv_0e724dbebd372526: function(arg0, arg1, arg2, arg3, arg4) {
            arg0.uniformMatrix4fv(arg1, arg2 !== 0, getArrayF32FromWasm0(arg3, arg4));
        },
        __wbg_useProgram_fe720ade4d3b6edb: function(arg0, arg1) {
            arg0.useProgram(arg1);
        },
        __wbg_userAgent_34463fd660ba4a2a: function() { return handleError(function (arg0, arg1) {
            const ret = arg1.userAgent;
            const ptr1 = passStringToWasm0(ret, wasm.__wbindgen_malloc, wasm.__wbindgen_realloc);
            const len1 = WASM_VECTOR_LEN;
            getDataViewMemory0().setInt32(arg0 + 4 * 1, len1, true);
            getDataViewMemory0().setInt32(arg0 + 4 * 0, ptr1, true);
        }, arguments); },
        __wbg_vertexAttribPointer_75f6ff47f6c9f8cb: function(arg0, arg1, arg2, arg3, arg4, arg5, arg6) {
            arg0.vertexAttribPointer(arg1 >>> 0, arg2, arg3 >>> 0, arg4 !== 0, arg5, arg6);
        },
        __wbg_viewport_df236eac68bc7467: function(arg0, arg1, arg2, arg3, arg4) {
            arg0.viewport(arg1, arg2, arg3, arg4);
        },
        __wbg_warn_f7ae1b2e66ccb930: function(arg0) {
            console.warn(arg0);
        },
        __wbg_wasClean_a9c77a7100d8534f: function(arg0) {
            const ret = arg0.wasClean;
            return ret;
        },
        __wbg_width_3d6b5cba33cc2cd2: function() { return handleError(function (arg0) {
            const ret = arg0.width;
            return ret;
        }, arguments); },
        __wbg_width_5f66bde2e810fbde: function(arg0) {
            const ret = arg0.width;
            return ret;
        },
        __wbg_width_75158459c067906d: function(arg0) {
            const ret = arg0.width;
            return ret;
        },
        __wbg_width_9bbf873307a2ac4e: function(arg0) {
            const ret = arg0.width;
            return ret;
        },
        __wbg_width_be8f36d66d37751f: function(arg0) {
            const ret = arg0.width;
            return ret;
        },
        __wbg_writeText_be1c3b83a3e46230: function(arg0, arg1, arg2) {
            const ret = arg0.writeText(getStringFromWasm0(arg1, arg2));
            return ret;
        },
        __wbindgen_cast_0000000000000001: function(arg0, arg1) {
            // Cast intrinsic for `Closure(Closure { dtor_idx: 1431, function: Function { arguments: [Externref], shim_idx: 1432, ret: Unit, inner_ret: Some(Unit) }, mutable: true }) -> Externref`.
            const ret = makeMutClosure(arg0, arg1, wasm.wasm_bindgen_89cb8f197c2bd7a9___closure__destroy___dyn_core_ed718c3d60ebd546___ops__function__FnMut__wasm_bindgen_89cb8f197c2bd7a9___JsValue____Output_______, wasm_bindgen_89cb8f197c2bd7a9___convert__closures_____invoke___wasm_bindgen_89cb8f197c2bd7a9___JsValue_____);
            return ret;
        },
        __wbindgen_cast_0000000000000002: function(arg0, arg1) {
            // Cast intrinsic for `Closure(Closure { dtor_idx: 1451, function: Function { arguments: [], shim_idx: 1452, ret: Unit, inner_ret: Some(Unit) }, mutable: true }) -> Externref`.
            const ret = makeMutClosure(arg0, arg1, wasm.wasm_bindgen_89cb8f197c2bd7a9___closure__destroy___dyn_core_ed718c3d60ebd546___ops__function__FnMut_____Output_______, wasm_bindgen_89cb8f197c2bd7a9___convert__closures_____invoke______);
            return ret;
        },
        __wbindgen_cast_0000000000000003: function(arg0, arg1) {
            // Cast intrinsic for `Closure(Closure { dtor_idx: 7, function: Function { arguments: [NamedExternref("CloseEvent")], shim_idx: 122, ret: Unit, inner_ret: Some(Unit) }, mutable: true }) -> Externref`.
            const ret = makeMutClosure(arg0, arg1, wasm.wasm_bindgen_89cb8f197c2bd7a9___closure__destroy___dyn_core_ed718c3d60ebd546___ops__function__FnMut__web_sys_583c6124992587af___features__gen_CloseEvent__CloseEvent____Output_______, wasm_bindgen_89cb8f197c2bd7a9___convert__closures_____invoke___web_sys_583c6124992587af___features__gen_CloseEvent__CloseEvent_____);
            return ret;
        },
        __wbindgen_cast_0000000000000004: function(arg0, arg1) {
            // Cast intrinsic for `Closure(Closure { dtor_idx: 7, function: Function { arguments: [NamedExternref("Event")], shim_idx: 122, ret: Unit, inner_ret: Some(Unit) }, mutable: true }) -> Externref`.
            const ret = makeMutClosure(arg0, arg1, wasm.wasm_bindgen_89cb8f197c2bd7a9___closure__destroy___dyn_core_ed718c3d60ebd546___ops__function__FnMut__web_sys_583c6124992587af___features__gen_CloseEvent__CloseEvent____Output_______, wasm_bindgen_89cb8f197c2bd7a9___convert__closures_____invoke___web_sys_583c6124992587af___features__gen_CloseEvent__CloseEvent_____);
            return ret;
        },
        __wbindgen_cast_0000000000000005: function(arg0, arg1) {
            // Cast intrinsic for `Closure(Closure { dtor_idx: 7, function: Function { arguments: [NamedExternref("MessageEvent")], shim_idx: 122, ret: Unit, inner_ret: Some(Unit) }, mutable: true }) -> Externref`.
            const ret = makeMutClosure(arg0, arg1, wasm.wasm_bindgen_89cb8f197c2bd7a9___closure__destroy___dyn_core_ed718c3d60ebd546___ops__function__FnMut__web_sys_583c6124992587af___features__gen_CloseEvent__CloseEvent____Output_______, wasm_bindgen_89cb8f197c2bd7a9___convert__closures_____invoke___web_sys_583c6124992587af___features__gen_CloseEvent__CloseEvent_____);
            return ret;
        },
        __wbindgen_cast_0000000000000006: function(arg0) {
            // Cast intrinsic for `F64 -> Externref`.
            const ret = arg0;
            return ret;
        },
        __wbindgen_cast_0000000000000007: function(arg0, arg1) {
            // Cast intrinsic for `Ref(Slice(F32)) -> NamedExternref("Float32Array")`.
            const ret = getArrayF32FromWasm0(arg0, arg1);
            return ret;
        },
        __wbindgen_cast_0000000000000008: function(arg0, arg1) {
            // Cast intrinsic for `Ref(Slice(U16)) -> NamedExternref("Uint16Array")`.
            const ret = getArrayU16FromWasm0(arg0, arg1);
            return ret;
        },
        __wbindgen_cast_0000000000000009: function(arg0, arg1) {
            // Cast intrinsic for `Ref(Slice(U32)) -> NamedExternref("Uint32Array")`.
            const ret = getArrayU32FromWasm0(arg0, arg1);
            return ret;
        },
        __wbindgen_cast_000000000000000a: function(arg0, arg1) {
            // Cast intrinsic for `Ref(String) -> Externref`.
            const ret = getStringFromWasm0(arg0, arg1);
            return ret;
        },
        __wbindgen_init_externref_table: function() {
            const table = wasm.__wbindgen_externrefs;
            const offset = table.grow(4);
            table.set(0, undefined);
            table.set(offset + 0, undefined);
            table.set(offset + 1, null);
            table.set(offset + 2, true);
            table.set(offset + 3, false);
        },
    };
    return {
        __proto__: null,
        "./vm_rust_bg.js": import0,
        "dirplayer-js-api": import1,
        "dirplayer-js-api": import2,
        "dirplayer-js-api": import3,
        "dirplayer-js-api": import4,
        "dirplayer-js-api": import5,
        "dirplayer-js-api": import6,
        "dirplayer-js-api": import7,
        "dirplayer-js-api": import8,
        "dirplayer-js-api": import9,
        "dirplayer-js-api": import10,
        "dirplayer-js-api": import11,
    };
}

const lOfflineAudioContext = (typeof OfflineAudioContext !== 'undefined' ? OfflineAudioContext : (typeof webkitOfflineAudioContext !== 'undefined' ? webkitOfflineAudioContext : undefined));
function wasm_bindgen_89cb8f197c2bd7a9___convert__closures_____invoke______(arg0, arg1) {
    wasm.wasm_bindgen_89cb8f197c2bd7a9___convert__closures_____invoke______(arg0, arg1);
}

function wasm_bindgen_89cb8f197c2bd7a9___convert__closures_____invoke___wasm_bindgen_89cb8f197c2bd7a9___JsValue_____(arg0, arg1, arg2) {
    wasm.wasm_bindgen_89cb8f197c2bd7a9___convert__closures_____invoke___wasm_bindgen_89cb8f197c2bd7a9___JsValue_____(arg0, arg1, arg2);
}

function wasm_bindgen_89cb8f197c2bd7a9___convert__closures_____invoke___web_sys_583c6124992587af___features__gen_CloseEvent__CloseEvent_____(arg0, arg1, arg2) {
    wasm.wasm_bindgen_89cb8f197c2bd7a9___convert__closures_____invoke___web_sys_583c6124992587af___features__gen_CloseEvent__CloseEvent_____(arg0, arg1, arg2);
}

function wasm_bindgen_89cb8f197c2bd7a9___convert__closures_____invoke___wasm_bindgen_89cb8f197c2bd7a9___JsValue__wasm_bindgen_89cb8f197c2bd7a9___JsValue_____(arg0, arg1, arg2, arg3) {
    wasm.wasm_bindgen_89cb8f197c2bd7a9___convert__closures_____invoke___wasm_bindgen_89cb8f197c2bd7a9___JsValue__wasm_bindgen_89cb8f197c2bd7a9___JsValue_____(arg0, arg1, arg2, arg3);
}


const __wbindgen_enum_AudioContextState = ["suspended", "running", "closed"];


const __wbindgen_enum_BinaryType = ["blob", "arraybuffer"];


const __wbindgen_enum_RequestMode = ["same-origin", "no-cors", "cors", "navigate"];
const JsBridgeBreakpointFinalization = (typeof FinalizationRegistry === 'undefined')
    ? { register: () => {}, unregister: () => {} }
    : new FinalizationRegistry(ptr => wasm.__wbg_jsbridgebreakpoint_free(ptr >>> 0, 1));
const OnMovieLoadedCallbackDataFinalization = (typeof FinalizationRegistry === 'undefined')
    ? { register: () => {}, unregister: () => {} }
    : new FinalizationRegistry(ptr => wasm.__wbg_onmovieloadedcallbackdata_free(ptr >>> 0, 1));
const OnScriptErrorCallbackDataFinalization = (typeof FinalizationRegistry === 'undefined')
    ? { register: () => {}, unregister: () => {} }
    : new FinalizationRegistry(ptr => wasm.__wbg_onscripterrorcallbackdata_free(ptr >>> 0, 1));
const WebAudioBackendFinalization = (typeof FinalizationRegistry === 'undefined')
    ? { register: () => {}, unregister: () => {} }
    : new FinalizationRegistry(ptr => wasm.__wbg_webaudiobackend_free(ptr >>> 0, 1));

function addToExternrefTable0(obj) {
    const idx = wasm.__externref_table_alloc();
    wasm.__wbindgen_externrefs.set(idx, obj);
    return idx;
}

const CLOSURE_DTORS = (typeof FinalizationRegistry === 'undefined')
    ? { register: () => {}, unregister: () => {} }
    : new FinalizationRegistry(state => state.dtor(state.a, state.b));

function debugString(val) {
    // primitive types
    const type = typeof val;
    if (type == 'number' || type == 'boolean' || val == null) {
        return  `${val}`;
    }
    if (type == 'string') {
        return `"${val}"`;
    }
    if (type == 'symbol') {
        const description = val.description;
        if (description == null) {
            return 'Symbol';
        } else {
            return `Symbol(${description})`;
        }
    }
    if (type == 'function') {
        const name = val.name;
        if (typeof name == 'string' && name.length > 0) {
            return `Function(${name})`;
        } else {
            return 'Function';
        }
    }
    // objects
    if (Array.isArray(val)) {
        const length = val.length;
        let debug = '[';
        if (length > 0) {
            debug += debugString(val[0]);
        }
        for(let i = 1; i < length; i++) {
            debug += ', ' + debugString(val[i]);
        }
        debug += ']';
        return debug;
    }
    // Test for built-in
    const builtInMatches = /\[object ([^\]]+)\]/.exec(toString.call(val));
    let className;
    if (builtInMatches && builtInMatches.length > 1) {
        className = builtInMatches[1];
    } else {
        // Failed to match the standard '[object ClassName]'
        return toString.call(val);
    }
    if (className == 'Object') {
        // we're a user defined class or Object
        // JSON.stringify avoids problems with cycles, and is generally much
        // easier than looping through ownProperties of `val`.
        try {
            return 'Object(' + JSON.stringify(val) + ')';
        } catch (_) {
            return 'Object';
        }
    }
    // errors
    if (val instanceof Error) {
        return `${val.name}: ${val.message}\n${val.stack}`;
    }
    // TODO we could test for more things here, like `Set`s and `Map`s.
    return className;
}

function getArrayF32FromWasm0(ptr, len) {
    ptr = ptr >>> 0;
    return getFloat32ArrayMemory0().subarray(ptr / 4, ptr / 4 + len);
}

function getArrayI32FromWasm0(ptr, len) {
    ptr = ptr >>> 0;
    return getInt32ArrayMemory0().subarray(ptr / 4, ptr / 4 + len);
}

function getArrayJsValueFromWasm0(ptr, len) {
    ptr = ptr >>> 0;
    const mem = getDataViewMemory0();
    const result = [];
    for (let i = ptr; i < ptr + 4 * len; i += 4) {
        result.push(wasm.__wbindgen_externrefs.get(mem.getUint32(i, true)));
    }
    wasm.__externref_drop_slice(ptr, len);
    return result;
}

function getArrayU16FromWasm0(ptr, len) {
    ptr = ptr >>> 0;
    return getUint16ArrayMemory0().subarray(ptr / 2, ptr / 2 + len);
}

function getArrayU32FromWasm0(ptr, len) {
    ptr = ptr >>> 0;
    return getUint32ArrayMemory0().subarray(ptr / 4, ptr / 4 + len);
}

function getArrayU8FromWasm0(ptr, len) {
    ptr = ptr >>> 0;
    return getUint8ArrayMemory0().subarray(ptr / 1, ptr / 1 + len);
}

function getClampedArrayU8FromWasm0(ptr, len) {
    ptr = ptr >>> 0;
    return getUint8ClampedArrayMemory0().subarray(ptr / 1, ptr / 1 + len);
}

let cachedDataViewMemory0 = null;
function getDataViewMemory0() {
    if (cachedDataViewMemory0 === null || cachedDataViewMemory0.buffer.detached === true || (cachedDataViewMemory0.buffer.detached === undefined && cachedDataViewMemory0.buffer !== wasm.memory.buffer)) {
        cachedDataViewMemory0 = new DataView(wasm.memory.buffer);
    }
    return cachedDataViewMemory0;
}

let cachedFloat32ArrayMemory0 = null;
function getFloat32ArrayMemory0() {
    if (cachedFloat32ArrayMemory0 === null || cachedFloat32ArrayMemory0.byteLength === 0) {
        cachedFloat32ArrayMemory0 = new Float32Array(wasm.memory.buffer);
    }
    return cachedFloat32ArrayMemory0;
}

let cachedInt32ArrayMemory0 = null;
function getInt32ArrayMemory0() {
    if (cachedInt32ArrayMemory0 === null || cachedInt32ArrayMemory0.byteLength === 0) {
        cachedInt32ArrayMemory0 = new Int32Array(wasm.memory.buffer);
    }
    return cachedInt32ArrayMemory0;
}

function getStringFromWasm0(ptr, len) {
    ptr = ptr >>> 0;
    return decodeText(ptr, len);
}

let cachedUint16ArrayMemory0 = null;
function getUint16ArrayMemory0() {
    if (cachedUint16ArrayMemory0 === null || cachedUint16ArrayMemory0.byteLength === 0) {
        cachedUint16ArrayMemory0 = new Uint16Array(wasm.memory.buffer);
    }
    return cachedUint16ArrayMemory0;
}

let cachedUint32ArrayMemory0 = null;
function getUint32ArrayMemory0() {
    if (cachedUint32ArrayMemory0 === null || cachedUint32ArrayMemory0.byteLength === 0) {
        cachedUint32ArrayMemory0 = new Uint32Array(wasm.memory.buffer);
    }
    return cachedUint32ArrayMemory0;
}

let cachedUint8ArrayMemory0 = null;
function getUint8ArrayMemory0() {
    if (cachedUint8ArrayMemory0 === null || cachedUint8ArrayMemory0.byteLength === 0) {
        cachedUint8ArrayMemory0 = new Uint8Array(wasm.memory.buffer);
    }
    return cachedUint8ArrayMemory0;
}

let cachedUint8ClampedArrayMemory0 = null;
function getUint8ClampedArrayMemory0() {
    if (cachedUint8ClampedArrayMemory0 === null || cachedUint8ClampedArrayMemory0.byteLength === 0) {
        cachedUint8ClampedArrayMemory0 = new Uint8ClampedArray(wasm.memory.buffer);
    }
    return cachedUint8ClampedArrayMemory0;
}

function handleError(f, args) {
    try {
        return f.apply(this, args);
    } catch (e) {
        const idx = addToExternrefTable0(e);
        wasm.__wbindgen_exn_store(idx);
    }
}

function isLikeNone(x) {
    return x === undefined || x === null;
}

function makeMutClosure(arg0, arg1, dtor, f) {
    const state = { a: arg0, b: arg1, cnt: 1, dtor };
    const real = (...args) => {

        // First up with a closure we increment the internal reference
        // count. This ensures that the Rust closure environment won't
        // be deallocated while we're invoking it.
        state.cnt++;
        const a = state.a;
        state.a = 0;
        try {
            return f(a, state.b, ...args);
        } finally {
            state.a = a;
            real._wbg_cb_unref();
        }
    };
    real._wbg_cb_unref = () => {
        if (--state.cnt === 0) {
            state.dtor(state.a, state.b);
            state.a = 0;
            CLOSURE_DTORS.unregister(state);
        }
    };
    CLOSURE_DTORS.register(real, state, state);
    return real;
}

function passArray32ToWasm0(arg, malloc) {
    const ptr = malloc(arg.length * 4, 4) >>> 0;
    getUint32ArrayMemory0().set(arg, ptr / 4);
    WASM_VECTOR_LEN = arg.length;
    return ptr;
}

function passArray8ToWasm0(arg, malloc) {
    const ptr = malloc(arg.length * 1, 1) >>> 0;
    getUint8ArrayMemory0().set(arg, ptr / 1);
    WASM_VECTOR_LEN = arg.length;
    return ptr;
}

function passStringToWasm0(arg, malloc, realloc) {
    if (realloc === undefined) {
        const buf = cachedTextEncoder.encode(arg);
        const ptr = malloc(buf.length, 1) >>> 0;
        getUint8ArrayMemory0().subarray(ptr, ptr + buf.length).set(buf);
        WASM_VECTOR_LEN = buf.length;
        return ptr;
    }

    let len = arg.length;
    let ptr = malloc(len, 1) >>> 0;

    const mem = getUint8ArrayMemory0();

    let offset = 0;

    for (; offset < len; offset++) {
        const code = arg.charCodeAt(offset);
        if (code > 0x7F) break;
        mem[ptr + offset] = code;
    }
    if (offset !== len) {
        if (offset !== 0) {
            arg = arg.slice(offset);
        }
        ptr = realloc(ptr, len, len = offset + arg.length * 3, 1) >>> 0;
        const view = getUint8ArrayMemory0().subarray(ptr + offset, ptr + len);
        const ret = cachedTextEncoder.encodeInto(arg, view);

        offset += ret.written;
        ptr = realloc(ptr, len, offset, 1) >>> 0;
    }

    WASM_VECTOR_LEN = offset;
    return ptr;
}

function takeFromExternrefTable0(idx) {
    const value = wasm.__wbindgen_externrefs.get(idx);
    wasm.__externref_table_dealloc(idx);
    return value;
}

let cachedTextDecoder = new TextDecoder('utf-8', { ignoreBOM: true, fatal: true });
cachedTextDecoder.decode();
const MAX_SAFARI_DECODE_BYTES = 2146435072;
let numBytesDecoded = 0;
function decodeText(ptr, len) {
    numBytesDecoded += len;
    if (numBytesDecoded >= MAX_SAFARI_DECODE_BYTES) {
        cachedTextDecoder = new TextDecoder('utf-8', { ignoreBOM: true, fatal: true });
        cachedTextDecoder.decode();
        numBytesDecoded = len;
    }
    return cachedTextDecoder.decode(getUint8ArrayMemory0().subarray(ptr, ptr + len));
}

const cachedTextEncoder = new TextEncoder();

if (!('encodeInto' in cachedTextEncoder)) {
    cachedTextEncoder.encodeInto = function (arg, view) {
        const buf = cachedTextEncoder.encode(arg);
        view.set(buf);
        return {
            read: arg.length,
            written: buf.length
        };
    };
}

let WASM_VECTOR_LEN = 0;

let wasmModule, wasm;
function __wbg_finalize_init(instance, module) {
    wasm = instance.exports;
    wasmModule = module;
    cachedDataViewMemory0 = null;
    cachedFloat32ArrayMemory0 = null;
    cachedInt32ArrayMemory0 = null;
    cachedUint16ArrayMemory0 = null;
    cachedUint32ArrayMemory0 = null;
    cachedUint8ArrayMemory0 = null;
    cachedUint8ClampedArrayMemory0 = null;
    wasm.__wbindgen_start();
    return wasm;
}

async function __wbg_load(module, imports) {
    if (typeof Response === 'function' && module instanceof Response) {
        if (typeof WebAssembly.instantiateStreaming === 'function') {
            try {
                return await WebAssembly.instantiateStreaming(module, imports);
            } catch (e) {
                const validResponse = module.ok && expectedResponseType(module.type);

                if (validResponse && module.headers.get('Content-Type') !== 'application/wasm') {
                    console.warn("`WebAssembly.instantiateStreaming` failed because your server does not serve Wasm with `application/wasm` MIME type. Falling back to `WebAssembly.instantiate` which is slower. Original error:\n", e);

                } else { throw e; }
            }
        }

        const bytes = await module.arrayBuffer();
        return await WebAssembly.instantiate(bytes, imports);
    } else {
        const instance = await WebAssembly.instantiate(module, imports);

        if (instance instanceof WebAssembly.Instance) {
            return { instance, module };
        } else {
            return instance;
        }
    }

    function expectedResponseType(type) {
        switch (type) {
            case 'basic': case 'cors': case 'default': return true;
        }
        return false;
    }
}

function initSync(module) {
    if (wasm !== undefined) return wasm;


    if (module !== undefined) {
        if (Object.getPrototypeOf(module) === Object.prototype) {
            ({module} = module)
        } else {
            console.warn('using deprecated parameters for `initSync()`; pass a single object instead')
        }
    }

    const imports = __wbg_get_imports();
    if (!(module instanceof WebAssembly.Module)) {
        module = new WebAssembly.Module(module);
    }
    const instance = new WebAssembly.Instance(module, imports);
    return __wbg_finalize_init(instance, module);
}

async function __wbg_init(module_or_path) {
    if (wasm !== undefined) return wasm;


    if (module_or_path !== undefined) {
        if (Object.getPrototypeOf(module_or_path) === Object.prototype) {
            ({module_or_path} = module_or_path)
        } else {
            console.warn('using deprecated parameters for the initialization function; pass a single object instead')
        }
    }

    if (module_or_path === undefined) {
        module_or_path = new URL('vm_rust_bg.wasm', import.meta.url);
    }
    const imports = __wbg_get_imports();

    if (typeof module_or_path === 'string' || (typeof Request === 'function' && module_or_path instanceof Request) || (typeof URL === 'function' && module_or_path instanceof URL)) {
        module_or_path = fetch(module_or_path);
    }

    const { instance, module } = await __wbg_load(await module_or_path, imports);

    return __wbg_finalize_init(instance, module);
}

export { initSync, __wbg_init as default };
