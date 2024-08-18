#include QMK_KEYBOARD_H

// COMBOS
const uint16_t PROGMEM nav_layer[] = {LT(1,KC_SPC), LT(2,KC_BSPC), COMBO_END};
combo_t key_combos[] = {
    COMBO(nav_layer, TG(3)),
};

// TAP DANCE
enum {
 TD_COMM_SCLN,
};

tap_dance_action_t tap_dance_actions[] = {
  [TD_COMM_SCLN] = ACTION_TAP_DANCE_DOUBLE(KC_COMM, KC_SCLN),
};

// TAPPING TERM PER KEY
// https://github.com/qmk/qmk_firmware/blob/master/docs/tap_hold.md
uint16_t get_tapping_term(uint16_t keycode, keyrecord_t *record) {
  switch (keycode) {
    case KC_COMM:
      return 40;
    case KC_TAB:
      return 250;
    default:
      return TAPPING_TERM;
    }
}

// KEYMAPS
const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
	[0] = LAYOUT_split_3x5_2(KC_Q, KC_W, KC_E, KC_R, KC_T, KC_Y, KC_U, KC_I, KC_O, KC_P, KC_A, KC_S, KC_D, KC_F, KC_G, KC_H, KC_J, KC_K, KC_L, MT(MOD_RCTL, KC_ESC), MT(MOD_RALT,KC_Z), MT(MOD_LGUI,KC_X), KC_C, KC_V, KC_B, KC_N, KC_M, TD(TD_COMM_SCLN), KC_DOT, MT(MOD_RALT, KC_QUOT), MT(MOD_LSFT,KC_TAB), LT(1,KC_SPC), LT(2,KC_BSPC), MT(MOD_RSFT,KC_ENT)),
	[1] = LAYOUT_split_3x5_2(KC_COLN, KC_PERC, KC_PEQL, KC_BSLS, KC_TAB, KC_NO, KC_4, KC_5, KC_6, KC_NO, KC_PAST, KC_PPLS, KC_PMNS, KC_PSLS, KC_SPC, KC_COMM, KC_1, KC_2, KC_3, MT(MOD_RCTL,KC_0), KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_PCMM, KC_7, KC_8, KC_9, KC_RALT,KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS),
	[2] = LAYOUT_split_3x5_2(KC_QUES, KC_TILD, KC_EXLM, KC_PIPE, KC_AT, KC_NO, KC_NO, KC_CIRC, KC_DLR, KC_NO, KC_AMPR, KC_UNDS, KC_DQUO, KC_HASH, KC_GRV, KC_NO, KC_LPRN, KC_LCBR, KC_LBRC, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_RPRN, KC_RCBR, KC_RBRC, KC_RALT, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS),
	[3] = LAYOUT_split_3x5_2(KC_WH_L, KC_WH_D, KC_WH_U, KC_WH_R, KC_NO, KC_NO, KC_NO, KC_HOME, KC_END, KC_NO, KC_MS_L, KC_MS_D, KC_MS_U, KC_MS_R, KC_BTN1, KC_LEFT, KC_DOWN, KC_UP, KC_RGHT, KC_TRNS, KC_NO, KC_NO, KC_NO, KC_NO, KC_BTN2, KC_NO, KC_MUTE, KC_VOLD, KC_VOLU, TO(4), KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS),
	[4] = LAYOUT_split_3x5_2(KC_1, KC_2, KC_3, KC_R, KC_T, KC_Y, KC_4, KC_5, KC_6, KC_P, KC_A, KC_S, KC_D, KC_F, KC_G, KC_MS_L, KC_MS_D, KC_MS_U, KC_MS_R, KC_E, KC_Z, KC_X, KC_C, KC_V, KC_B, KC_N, KC_M, KC_COMM, KC_DOT, TO(0), KC_LSFT, KC_SPC, KC_BTN1, KC_BTN2),
};

#if defined(ENCODER_ENABLE) && defined(ENCODER_MAP_ENABLE)
const uint16_t PROGMEM encoder_map[][NUM_ENCODERS][NUM_DIRECTIONS] = {

};
#endif // defined(ENCODER_ENABLE) && defined(ENCODER_MAP_ENABLE)




