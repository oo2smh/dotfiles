#include QMK_KEYBOARD_H
#include <stdint.h>
#define TMUX_CASE(code, key) case code: tmux(key); return false;
#define MT_SFT_MAGIC MT(MOD_LSFT, KC_0)


/////////////////////////////////////////////////
// OVERVIEW
/////////////////////////////////////////////////
enum layers {
    _BASE,
    _XOURNAL,
    _MOUSE,
    _QUICK_FIRE,
    _SYMBOLS,
    _ARROW_NUMPAD,
    _TMUX,
};

enum custom_keycodes {
    TM_PANE_CLOSE = SAFE_RANGE,
    TM_PANEV_NEW,
    TM_PANEH_NEW,
    TM_P_FULL,
    TM_WIN_NEW,
    TM_WIN_CLOSE,
    TM_DETACH,
    TM_COPY,
    TM_PASTE,
    TM_EVEN,
    TM_P_RESIZE_LEFT,
    TM_P_RESIZE_RIGHT,
    TM_P_RESIZE_UP,
    TM_P_RESIZE_DOWN,
    TM_SESS_MANAGER,
    TM_RN_SESS,
    TM_RN_WIN,
    TM_RN_PN,
    TM_PREV_SESS,
    TM_NEXT_SESS,
    TM_CMD,
    TM1,
    TM2,
    TM3,
    TM4,
    TM5,
    TM6,
    TM_P_NEXT,
    TM_P_PREV,

    XOURNAL_YELLOW,
    XOURNAL_ORANGE,
    XOURNAL_PINK,
    XOURNAL_BLUE,

    ALTREP2,
    DEL_WORD,
    DEL_LINE,
    SPC_SFT_M,
};


// makes OSM escape OSL
void post_process_record_user(uint16_t keycode, keyrecord_t *record) {
    if (IS_QK_ONE_SHOT_MOD(keycode) && is_oneshot_layer_active() && record->event.pressed) {
        clear_oneshot_layer_state(ONESHOT_OTHER_KEY_PRESSED);
    }
    return;
}

/////////////////////////////////////////////////
// COMBOS
/////////////////////////////////////////////////
enum combos {
    MOUSE_RIGHT_TOGGLE,
    TMUX_THUMB,
    QUICK_FIRE_LAYER,
    ESC_RIGHT,
    ESC_LEFT,
    KEY_B,
    KEY_F,
    KEY_J,
    KEY_X,
    KEY_Q,
    KEY_Z,
    KEY_V,
    KEY_PPLS,
    OSALT,
    OSSFT,
    LEFT_ENTER,
    MOUSE_LAYER,
    MAIN_LAYER,
    SFT_THUMB,
    ZEN_LAYER,
    CAPS_WORD,
    SLEEP,
    SHUTDOWN,
    QUOT_CAPS,
    DEL_WORD_C,
    SPC_SFT,
};

const uint16_t PROGMEM mouse_right_toggle[] = {KC_D, LT(_SYMBOLS, KC_R), COMBO_END};
const uint16_t PROGMEM spc_sft[] = {LT(_ARROW_NUMPAD, KC_SPC), MT(MOD_RCTL, KC_ENT), COMBO_END};
const uint16_t PROGMEM quot_caps[] = {LT(_ARROW_NUMPAD, KC_SPC), KC_QUOT, COMBO_END};
const uint16_t PROGMEM mouse_layer[] = {MT(MOD_LALT, KC_BSPC), LT(_ARROW_NUMPAD, KC_SPC), COMBO_END};
const uint16_t PROGMEM main_layer[] = {MT(MOD_LCTL, KC_DOT), LT(_ARROW_NUMPAD, KC_SPC), COMBO_END};
const uint16_t PROGMEM sft_thumb[] = {MT(MOD_LCTL, KC_TAB), MT(MOD_RCTL, KC_ENT), COMBO_END};
const uint16_t PROGMEM zen_layer[] = {MT_SFT_MAGIC, LT(_ARROW_NUMPAD, KC_SPC), COMBO_END};
const uint16_t PROGMEM osalt[] = {KC_G, KC_W,COMBO_END};
const uint16_t PROGMEM ossft[] = {KC_C, KC_S,COMBO_END};
const uint16_t PROGMEM del_word_c[] = {LT(_SYMBOLS, KC_R), MT(MOD_LCTL, KC_TAB), COMBO_END};

const uint16_t PROGMEM tmux_c[] = {LT(_ARROW_NUMPAD, KC_SPC), LT(_SYMBOLS,KC_R), COMBO_END};
const uint16_t PROGMEM caps_word[] = {MT(MOD_LALT, KC_BSPC), KC_G, COMBO_END};
const uint16_t PROGMEM left_enter[] = {MT(MOD_LCTL, KC_DOT), MT(MOD_LALT, KC_BSPC), COMBO_END};
const uint16_t PROGMEM quick_fire_layer[] = {MT(MOD_LCTL, KC_TAB), LT(_ARROW_NUMPAD, KC_SPC), COMBO_END};
const uint16_t PROGMEM esc_right[] = {MT(MOD_RCTL, KC_ENT), LT(_SYMBOLS, KC_R), COMBO_END};
const uint16_t PROGMEM esc_left[] = {MT(MOD_LALT, KC_BSPC) , MT(MOD_LGUI, KC_COMM), COMBO_END};

const uint16_t PROGMEM key_b[] = {LT(_SYMBOLS, KC_R), KC_T, COMBO_END};
const uint16_t PROGMEM key_f[] = {LT(_SYMBOLS, KC_R), KC_N, COMBO_END};
const uint16_t PROGMEM key_j[] = {LT(_SYMBOLS, KC_R), KC_H, COMBO_END};
const uint16_t PROGMEM key_x[] = {LT(_SYMBOLS, KC_R), KC_S, COMBO_END};

const uint16_t PROGMEM key_v[] = {LT(_ARROW_NUMPAD, KC_SPC), KC_C, COMBO_END};
const uint16_t PROGMEM key_q[] = {LT(_SYMBOLS, KC_R), KC_G, COMBO_END};
const uint16_t PROGMEM key_z[] = {LT(_SYMBOLS, KC_R), KC_W, COMBO_END};
const uint16_t PROGMEM key_ppls[] = {LT(_SYMBOLS, KC_R), KC_M, COMBO_END};
const uint16_t PROGMEM sleep[] = {MT_SFT_MAGIC, MT(MOD_LCTL, KC_DOT), MT(MOD_LALT, KC_BSPC), MT(MOD_LGUI, KC_COMM),  MT(MOD_LCTL, KC_TAB), COMBO_END};
const uint16_t PROGMEM shutdown[] = {MT_SFT_MAGIC, MT(MOD_LCTL, KC_DOT), MT(MOD_LALT, KC_BSPC), MT(MOD_LGUI, KC_COMM), LT(_ARROW_NUMPAD, KC_SPC), COMBO_END};

combo_t key_combos[26] = {
    [MOUSE_RIGHT_TOGGLE] = COMBO(mouse_right_toggle, MO(_MOUSE)),
    [DEL_WORD_C] = COMBO(del_word_c, DEL_WORD),
    [SPC_SFT] = COMBO(spc_sft, SPC_SFT_M),
    [TMUX_THUMB] = COMBO(tmux_c, OSL(_TMUX)),
    [QUICK_FIRE_LAYER] = COMBO(quick_fire_layer, OSL(_QUICK_FIRE)),
    [ESC_RIGHT] = COMBO(esc_right, KC_ESC),
    [ESC_LEFT] = COMBO(esc_left, KC_ESC),
    [KEY_X] = COMBO(key_x, KC_X),
    [KEY_Q] = COMBO(key_q, KC_Q),
    [KEY_Z] = COMBO(key_z, KC_Z),
    [KEY_V] = COMBO(key_v, KC_V),
    [KEY_J] = COMBO(key_j, KC_J),
    [KEY_F] = COMBO(key_f, KC_F),
    [KEY_B] = COMBO(key_b, KC_B),
    [KEY_PPLS] = COMBO(key_ppls, KC_PPLS),
    [OSALT] = COMBO(osalt, OSM(MOD_LALT)),
    [OSSFT] = COMBO(ossft, OSM(MOD_LSFT)),
    [LEFT_ENTER] = COMBO(left_enter, KC_ENT),
    [MOUSE_LAYER] = COMBO(mouse_layer, TO(_MOUSE)),
    [MAIN_LAYER] = COMBO(main_layer, TO(_BASE)),
    [SFT_THUMB] = COMBO(sft_thumb, OSM(MOD_LSFT)),
    [ZEN_LAYER] = COMBO(zen_layer, TO(_XOURNAL)),
    [CAPS_WORD] = COMBO(caps_word, CW_TOGG),
    [SLEEP] = COMBO(sleep, KC_SLEP),
    [SHUTDOWN] = COMBO(shutdown, KC_PWR),
    [QUOT_CAPS] = COMBO_ACTION(quot_caps),
};

void process_combo_event(uint16_t combo_index, bool pressed) {
    switch(combo_index) {
        case QUOT_CAPS:
            if (pressed) {
                // On combo press, activate Alt and the numpad layer
                tap_code16(KC_QUOT);
                add_oneshot_mods(MOD_BIT(KC_LSFT));
            }
            break;
    }
}

/////////////////////////////////////////////////
// MACROS
/////////////////////////////////////////////////
bool remember_last_key_user(uint16_t keycode, keyrecord_t* record,
                            uint8_t* remembered_mods) {
    switch (keycode) {
        case MT_SFT_MAGIC:
        case QK_AREP:
            return false;  // Ignore ALTREP keys.
    }

    return true;  // Other keys can be repeated.
};

// main AREP on pinky fingers
uint16_t get_alt_repeat_key_keycode_user(uint16_t keycode, uint8_t mods) {
    switch (keycode) {
        case KC_RIGHT: return KC_RIGHT;
        case KC_UP: return KC_UP;
        case KC_DOWN: return KC_DOWN;
        case KC_LEFT: return KC_LEFT;
        case MT(MOD_LALT, KC_BSPC): return KC_BSPC;
        case KC_Y: return KC_I;
        case KC_B: return KC_R;
        case KC_I: return KC_Y;
        case KC_O: return KC_E;
        case KC_E: return KC_O;
        case KC_A: return KC_U;
        case KC_U: return KC_A;
        case KC_S: return KC_W;
        case KC_P: return KC_S;
        case KC_W: return KC_N;
        case KC_G: return KC_L;
        case KC_L: return KC_M;
        case KC_M: return KC_P;
        case KC_R: return KC_F;
        case KC_F: return KC_R;
        case KC_D: return KC_M;
        case MT(MOD_LCTL, KC_DOT): return KC_DOT;
        case MT(MOD_RSFT,KC_PMNS): return S(KC_DOT);
        case KC_1: return KC_4;
        case KC_2: return KC_5;
        case KC_3: return KC_6;
        case KC_4: return KC_1;
        case KC_5: return KC_2;
        case KC_6: return KC_3;
        case LT(_ARROW_NUMPAD, KC_SPC): return OSM(MOD_LSFT); // doesn't work
        case KC_SPC: return OSM(MOD_LSFT);
    }
    return false;  // Defer to default definitions.
}

void tmux(uint16_t keycode) {
    register_code(KC_LCTL);
    tap_code(KC_B);
    unregister_code(KC_LCTL);
    tap_code16(keycode);
}

void tmux_resize(uint8_t dir) {
    register_code(KC_LCTL);
    tap_code(KC_B);
    unregister_code(KC_LCTL);
    register_code(KC_LALT);
    tap_code(dir);
    unregister_code(KC_LALT);
}

void tmux_close(uint16_t keycode) {
    tmux(keycode);
    tap_code(KC_Y);
}

void activate_pen_mode(uint16_t keycode) {
    register_code(KC_LCTL);
    register_code(KC_LSFT);
    tap_code16(KC_P);
    unregister_code(KC_LCTL);
    unregister_code(KC_LSFT);
    tap_code16(keycode);
}

bool process_record_user(uint16_t keycode, keyrecord_t* record) {
    switch (keycode) {
        case XOURNAL_PINK:
            if (record->event.pressed) {
                activate_pen_mode(KC_8);
            }
            break;
        case XOURNAL_YELLOW:
            if (record->event.pressed) {
                activate_pen_mode(KC_0);
            }
            break;
        case XOURNAL_BLUE:
            if (record->event.pressed) {
                activate_pen_mode(KC_3);
            }
            break;
        case XOURNAL_ORANGE:
            if (record->event.pressed) {
                activate_pen_mode(KC_9);
            }
            break;
        case MT_SFT_MAGIC:
            if (record->tap.count) {  // On tap.
                // For Alternate Repeat Key, replace the next line with
                alt_repeat_key_invoke(&record->event);
                return false;  // Skip default handling.
            };
            break;
        case SPC_SFT_M:
            if (record->event.pressed) {
                tap_code(KC_SPC);
                add_oneshot_mods(MOD_BIT(KC_LSFT));
            }
            break;
        case DEL_WORD:
            if (record->event.pressed) {
                add_oneshot_mods(MOD_BIT(KC_LCTL));
                tap_code(KC_BSPC);
            }
            break;
        case DEL_LINE:
            if (record->event.pressed) {
                tap_code(KC_END);
                add_oneshot_mods(MOD_BIT(KC_LSFT));
                tap_code(KC_HOME);
                tap_code(KC_BSPC);
                add_oneshot_mods(MOD_BIT(KC_LCTL));
                tap_code(KC_U); // terminal line delete
            }
            break;
        case TM_WIN_NEW:
            if (record->event.pressed) {
                tmux(KC_C);
            }
            return false;
        case TM_PANE_CLOSE:
            if (record->event.pressed) {
                tmux_close(KC_X);
            }
            return false;

        case TM_PANEV_NEW:
            if (record->event.pressed) {
                tmux(KC_PERC);
            }
            return false;

        case TM_PANEH_NEW:
            if (record->event.pressed) {
                tmux(KC_DQUO);
            }
            return false;


        case TM_P_NEXT:
            if (record->event.pressed) {
                tmux(KC_O);
            }
            return false;

        case TM_P_PREV:
            if (record->event.pressed) {
                tmux(KC_SCLN);
            }
            return false;

        case TM_EVEN:
            if (record->event.pressed) {
                tmux(KC_E);
            }
            return false;

            TMUX_CASE(TM1, KC_1)
            TMUX_CASE(TM2, KC_2)
            TMUX_CASE(TM3, KC_3)
            TMUX_CASE(TM4, KC_4)
            TMUX_CASE(TM5, KC_5)
            TMUX_CASE(TM6, KC_6)
            TMUX_CASE(TM_SESS_MANAGER, KC_S)
            TMUX_CASE(TM_DETACH, KC_D)

        case TM_WIN_CLOSE:
            if (record->event.pressed) {
                tmux_close(KC_AMPR);
            }
            return false;

        case TM_P_RESIZE_LEFT:
            if (record->event.pressed) {
                tmux_resize(KC_LEFT);
            }

            return false;

        case TM_P_RESIZE_RIGHT:
            if (record->event.pressed) {
                tmux_resize(KC_RIGHT);

            }
            return false;

        case TM_P_RESIZE_UP:
            if (record->event.pressed) {
                tmux_resize(KC_UP);
            }
            return false;

        case TM_P_RESIZE_DOWN:
            if (record->event.pressed) {
                tmux_resize(KC_DOWN);
            }
            return false;

        case TM_RN_WIN:
            if (record->event.pressed) {
                tmux(KC_COMM);
            }
            return false;

        case TM_RN_PN:
            if (record->event.pressed) {
                tmux_resize(KC_DOT);
            }
            return false;

        case TM_RN_SESS:
            if (record->event.pressed) {
                tmux(KC_DLR);
            }
            return false;

        case TM_PREV_SESS:
            if (record->event.pressed) {
                tmux(KC_LPRN);
            }
            return false;

            if (record->event.pressed) {
                case TM_NEXT_SESS:
                    tmux(KC_RPRN);
            }
            return false;

        case TM_CMD:
            if (record->event.pressed) {
                tmux(KC_COLN);
                return false;
            }

        case TM_PASTE:
            if (record->event.pressed) {
                tmux(KC_RBRC);
            }
            return false;

        case TM_COPY:
            if (record->event.pressed) {
                tmux(KC_LBRC);
            }
            return false;

        case TM_P_FULL:
            if (record->event.pressed) {
                tmux(KC_Z);
            }
            return false;

    }
    return true;
};



/////////////////////////////////////////////////
// KEYMAPS
/////////////////////////////////////////////////
const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
    [_BASE] = LAYOUT_split_3x5_2(KC_QUOT, KC_Y, KC_O, KC_U, KC_SPC, KC_PAST, KC_L, KC_D, KC_P, KC_UNDS, KC_C, KC_I, KC_E, KC_A, QK_REP, QK_REP, KC_H, KC_T, KC_N, KC_S, MT_SFT_MAGIC, MT(MOD_LCTL,KC_DOT), MT(MOD_LALT, KC_BSPC), MT(MOD_LGUI, KC_COMM), KC_SCLN, KC_K, KC_M, KC_G, KC_W, MT(MOD_RSFT,KC_PMNS), MT(MOD_LCTL, KC_TAB), LT(_ARROW_NUMPAD, KC_SPC), LT(_SYMBOLS, KC_R), MT(MOD_RCTL, KC_ENT)),

    [_XOURNAL] = LAYOUT_split_3x5_2(KC_WH_L, KC_WH_D, KC_WH_U, KC_WH_R, KC_F9, KC_F11, KC_F4, KC_F5, KC_F6, KC_NO, XOURNAL_PINK, XOURNAL_ORANGE, XOURNAL_BLUE, XOURNAL_YELLOW, KC_TRNS, KC_F12, KC_F1, KC_F2, KC_F3, KC_F10, KC_PGDN, KC_PGUP, RCS(KC_E), C(KC_D), RCS(KC_DEL), KC_F13, KC_F7, KC_F8, KC_F9, KC_NO, RCS(KC_G), MT(MOD_LCTL, KC_DEL), KC_TRNS, KC_TRNS),

    [_MOUSE] = LAYOUT_split_3x5_2(KC_WH_L, KC_WH_D, KC_WH_U, KC_WH_R, KC_BTN3, KC_I, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_MS_L, KC_MS_D, KC_MS_U, KC_MS_R, KC_BTN2, QK_REP, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, MT(MOD_LALT, KC_G), KC_TRNS, KC_TRNS, KC_TRNS, KC_BTN1, LT(_ARROW_NUMPAD, KC_R), KC_TRNS),

    // this layer corresponds with the kybd shortcuts set in hypr
    [_QUICK_FIRE] = LAYOUT_split_3x5_2(KC_VOLD, KC_VOLU, MEH(KC_V), MEH(KC_C), MEH(KC_P), KC_F10, KC_F1, KC_F2, KC_F3, KC_F4, RCS(KC_H), A(KC_LEFT), A(KC_RIGHT), MEH(KC_T), QK_REP, QK_REP, A(KC_1), A(KC_2), A(KC_3), KC_F5, C(KC_Z), C(KC_X), C(KC_C), C(KC_V), C(KC_Y), KC_F12, A(KC_4), A(KC_5), A(KC_6), KC_F6, KC_TRNS, KC_TRNS, KC_WH_D, KC_WH_U),

    [_ARROW_NUMPAD] = LAYOUT_split_3x5_2(KC_DQUO, KC_7, KC_8, KC_9, KC_SPC, KC_TRNS, DEL_LINE, KC_HOME, KC_END, KC_TRNS, KC_LEFT, KC_DOWN, KC_UP, KC_RIGHT, KC_TRNS, QK_REP, KC_1, KC_2, KC_3, KC_0, KC_TRNS, KC_TRNS, KC_TRNS,  KC_TRNS, KC_COLN, KC_PPLS, KC_4, KC_5, KC_6, KC_TRNS, KC_TRNS, KC_TRNS, C(KC_LEFT), C(KC_RIGHT)),

    [_SYMBOLS] = LAYOUT_split_3x5_2(KC_GRV, KC_PERC, KC_PEQL, KC_PIPE, KC_SPC, KC_AT, KC_AMPR, KC_CIRC, KC_DLR, KC_TRNS, KC_TILDE, KC_HASH, KC_COLN, KC_SLSH, QK_REP, S(KC_COMM), KC_LPRN, KC_LCBR, KC_LBRC, S(KC_DOT), KC_TRNS, KC_QUES, KC_EXLM, KC_BSLS, KC_TRNS, KC_TRNS, KC_RPRN, KC_RCBR, KC_RBRC, KC_TRNS, KC_F, KC_TRNS, KC_TRNS, KC_TRNS),

    [_TMUX] = LAYOUT_split_3x5_2(TM_P_RESIZE_LEFT, TM_P_RESIZE_DOWN, TM_P_RESIZE_UP, TM_P_RESIZE_RIGHT, TM_EVEN, TM_RN_SESS, TM_SESS_MANAGER, TM_DETACH, TM_PREV_SESS, TM_NEXT_SESS, TM_PANEV_NEW, TM_P_PREV, TM_P_NEXT, TM_P_FULL, KC_TRNS, TM_RN_WIN, TM1, TM2, TM3, TM_WIN_NEW, TM_PANEH_NEW, TM_PANE_CLOSE, TM_COPY, TM_PASTE, C(KC_C), KC_TRNS, TM4, TM5, TM6, TM_CMD, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS),


};

#if defined(ENCODER_ENABLE) && defined(ENCODER_MAP_ENABLE)
const uint16_t PROGMEM encoder_map[][NUM_ENCODERS][NUM_DIRECTIONS] = TILDE
#endif // defined(ENCODER_ENABLE) && defined(ENCODER_MAP_ENABLE)

/////////////////////////////////////////////////
// REJECTED
/////////////////////////////////////////////////

