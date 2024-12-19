#include QMK_KEYBOARD_H

// COMBOS
const uint16_t PROGMEM mouse_layer[] = {MT(MOD_LSFT,KC_SPC), MT(MOD_RSFT,KC_BSPC), COMBO_END};
const uint16_t PROGMEM mouse_layer_left[] = {MT(MOD_LCTL, KC_X), LT(3, KC_TAB), COMBO_END};
const uint16_t PROGMEM main_layer[] = {LT(3,KC_TAB),MT(MOD_RSFT, KC_BSPC),COMBO_END};
const uint16_t PROGMEM main_layer_left[] = {KC_A, MT(MOD_LSFT, KC_SPC), COMBO_END};
const uint16_t PROGMEM zen_layer[] = {MT(MOD_LSFT, KC_Z), MT(MOD_LSFT, KC_SPC), COMBO_END};
const uint16_t PROGMEM caps_word[] = {LT(3,KC_TAB), LT(4, KC_ENT), COMBO_END};
const uint16_t PROGMEM sleep[] = {MT(MOD_LSFT, KC_Z), MT(MOD_LCTL, KC_X), MT(MOD_LALT, KC_C), MT(MOD_LGUI, KC_V), LT(3, KC_TAB), COMBO_END};
const uint16_t PROGMEM shutdown[] = {MT(MOD_LSFT, KC_Z), MT(MOD_LCTL, KC_X), MT(MOD_LALT, KC_C), MT(MOD_LGUI, KC_V), MT(MOD_LSFT, KC_SPC), COMBO_END};
const uint16_t PROGMEM esc[] = {MT(MOD_LSFT,KC_SPC), LT(4, KC_ENT), COMBO_END};
const uint16_t PROGMEM paste[] = {MT(MOD_LALT, KC_C), MT(MOD_LGUI, KC_V), COMBO_END};

combo_t key_combos[10] = {
    COMBO(mouse_layer, TO(2)),
    COMBO(mouse_layer_left, TO(2)),
    COMBO(main_layer, TO(0)),
    COMBO(main_layer_left, TO(0)),
    COMBO(zen_layer, TO(1)),
    COMBO(esc, KC_ESC),
    COMBO(caps_word, CW_TOGG),
    COMBO(sleep, KC_SLEP),
    COMBO(shutdown, KC_PWR),
    COMBO(paste,C(KC_V)),
};


// TAPPING TERM PER KEY
// https://github.com/qmk/qmk_firmware/blob/master/docs/tap_hold.md
uint16_t get_tapping_term(uint16_t keycode, keyrecord_t *record) {
  switch (keycode) {
    case KC_Z:
    case KC_X:
    case KC_V:
    case KC_TAB:
    case KC_J:
    case KC_K:
    case KC_L:
    case KC_A:
      return 200;
    default:
      return TAPPING_TERM;
    }
}
// KEYMAPS
// 0 BASE, 1 ZEN/FN, 2 MOUSE, 3 ARROWS/NUMPAD, 4 SYMBOLS
const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
    // BASE TEXT
    [0] = LAYOUT_split_3x5_2(KC_Q, KC_W, KC_E, KC_R, KC_T, KC_Y, KC_U, KC_I, KC_O, KC_P, KC_A, KC_S, KC_D, KC_F, KC_G, KC_H, MT(MOD_RGUI, KC_J), MT(MOD_RALT,KC_K), MT(MOD_RCTL,KC_L), MT(MOD_RSFT, KC_QUOT), MT(MOD_LSFT,KC_Z), MT(MOD_LCTL,KC_X), MT(MOD_LALT, KC_C), MT(MOD_LGUI,KC_V),KC_B, KC_N, KC_M, KC_COMM, KC_DOT, KC_SLSH, LT(3, KC_TAB), MT(MOD_LSFT,KC_SPC), MT(MOD_RSFT, KC_BSPC), LT(4,KC_ENT)),

    // ZEN/FN
    [1] = LAYOUT_split_3x5_2(KC_WH_L, KC_WH_D, KC_WH_U, KC_WH_R, S(KC_2), KC_F11, KC_F4, KC_F5, KC_F6, KC_NO, MT(MOD_LSFT, KC_ESC), KC_S, KC_BSPC, KC_I, KC_TRNS, KC_F12, KC_F1, KC_F2, KC_F3, KC_F10, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_H, KC_F13, KC_F7, KC_F8, KC_F9, KC_NO, LT(2, KC_TAB), MT(MOD_LCTL, KC_M), KC_TRNS, KC_TRNS),

    // MOUSE
    [2] = LAYOUT_split_3x5_2(KC_WH_L, KC_WH_D, KC_WH_U, KC_WH_R, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_MS_L, KC_MS_D, KC_MS_U, KC_MS_R, KC_BTN2, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_BTN1, KC_TRNS, KC_TRNS),

    // ARROWS/NUMPAD
    [3] = LAYOUT_split_3x5_2(KC_HOME, C(KC_PMNS), C(KC_PPLS), KC_END, KC_PGUP, KC_PAST, KC_4, KC_5, KC_6, KC_PPLS, KC_LEFT, KC_DOWN, KC_UP, KC_RIGHT, KC_PGDN, KC_DOT, MT(MOD_RGUI,KC_1), MT(MOD_RALT,KC_2), MT(MOD_RCTL,KC_3), MT(MOD_RSFT,KC_0), MT(MOD_LSFT, KC_MUTE), MT(MOD_LCTL, KC_VOLD), MT(MOD_LALT,KC_VOLU), MT(MOD_LGUI, KC_SPC), KC_TRNS, KC_PMNS, KC_7, KC_8, KC_9, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS),

    // SYMBOLS
    [4] = LAYOUT_split_3x5_2(KC_COLN, KC_PERC, KC_PEQL, KC_DLR, KC_CIRC, KC_NO, KC_AT, KC_EXLM, KC_AMPR, KC_NO, KC_PAST, KC_PMNS, KC_PPLS, KC_UNDS, KC_HASH, KC_SCLN, KC_LPRN, KC_LCBR, MT(MOD_RCTL, KC_LBRC), KC_PIPE, MT(MOD_LSFT, KC_BSLS), S(KC_COMM), KC_COLN, S(KC_DOT), KC_GRV, KC_TILDE, KC_RPRN, KC_RCBR, KC_RBRC, S(KC_SLSH), KC_TRNS, MT(MOD_LCTL, KC_SPC), KC_TRNS, KC_TRNS),
};

#if defined(ENCODER_ENABLE) && defined(ENCODER_MAP_ENABLE)
const uint16_t PROGMEM encoder_map[][NUM_ENCODERS][NUM_DIRECTIONS] = TILDE
#endif // defined(ENCODER_ENABLE) && defined(ENCODER_MAP_ENABLE)


/*********************
REJECTED
*********************/
// TAP DANCE

/*enum {*/
/* TD_COMM_SCLN,*/
/*};*/
/**/
/*tap_dance_action_t tap_dance_actions[] = {*/
/*  [TD_COMM_SCLN] = ACTION_TAP_DANCE_DOUBLE(KC_COMM, KC_SCLN),*/
/*};*/

