#include QMK_KEYBOARD_H
/////////////////////////////////////////////////
// OVERVIEW
/////////////////////////////////////////////////
enum layers {
    _BASE,
    _SYMBOLS,
    _MOUSE,
    _QUICK_FIRE,
    _ARROW_NUMPAD,
    _TMUX_FN,
};

enum custom_keycodes {

    // TMUX (10)
    TM_PANE_CLOSE = SAFE_RANGE,
    TM_PANEV_NEW,
    TM_PANEH_NEW,
    TM_WIN_NEW,
    TM_SESS_MANAGER,
    TM_RN_SESS,
    TM_RN_WIN,
    TM_PREV_SESS,
    TM_SAVE,
    TM_RESTORE,

    // XOURNAL
    XOURNAL_MAGENTA,
    XOURNAL_YELLOW,
    XOURNAL_ORANGE,
    XOURNAL_BLUE,
    XOURNAL_RED,
    XOURNAL_NEON,
    XOURNAL_GRAY,
    XOURNAL_RECT,
    XOURNAL_ELLIPSE,

    // NVIM
    NVIM_GV,
    NVIM_GU,
    NVIM_VIP,
    NVIM_PREV_HUNK,
    NVIM_NEXT_HUNK,
    NVIM_STAGE_HUNK,
    NVIM_RESET_HUNK,
    NVIM_STAGE_LINE,
    NVIM_YANK_REG_PASTE,
    NVIM_GX,

    // COMMON SYNERGIES
    MULTILINE_COMMENT,
    SPC_PEQL_SPC,
    SPC_PPLS_SPC,
    END_SCLN_ENT,
    CODEBLOCKS,

    // SYSTEM
    MOUSE_REF_VIEW,
    TEXT_TERM_VIEW,
    PASTE_AND_POP, // uses a custom shell script
    BSPC_WORD,
};

/////////////////////////////////////////////////
// VARIABLES
/////////////////////////////////////////////////

// THUMB
#define TH_TAB MT(MOD_LCTL, KC_TAB)
#define TH_ENT MT(MOD_RSFT, KC_ENT)
#define TH_SPC LT(_ARROW_NUMPAD, KC_SPC)
#define TH_R LT(_SYMBOLS, KC_R)

// LEFT BOT & RIGHT
#define LB_ALTREP MT(MOD_LSFT, KC_0)
#define LB_DOT MT(MOD_LCTL, KC_DOT)
#define LB_BSPC MT(MOD_LALT, KC_BSPC)
#define LB_COMM MT(MOD_LGUI, KC_COMM)

/////////////////////////////////////////////////
// COMBOS
/////////////////////////////////////////////////
// NAV
const uint16_t PROGMEM alt_tab_home[] = {TH_SPC, KC_I, KC_E, COMBO_END};
const uint16_t PROGMEM ctl_tab_home[] = {TH_SPC, KC_A, KC_E, COMBO_END};
const uint16_t PROGMEM sup_bspc_home[] = {TH_SPC, KC_A, KC_I, COMBO_END};
const uint16_t PROGMEM sup_tab_thumb[] = {TH_TAB, TH_ENT, TH_SPC, TH_R, COMBO_END};
const uint16_t PROGMEM sup_tab_left[] = {OSM(MOD_LSFT), KC_Y, COMBO_END};
const uint16_t PROGMEM sup_bspc_left[] = {TH_TAB, KC_Y, OSM(MOD_LSFT), COMBO_END};
const uint16_t PROGMEM sup_bspc_left2[] = {TH_SPC, KC_Y, OSM(MOD_LSFT), COMBO_END};
const uint16_t PROGMEM fullscreen_super[] = {TH_SPC, LB_BSPC, LB_COMM, COMBO_END};
const uint16_t PROGMEM fullscreen_alt[] = {TH_SPC, LB_DOT, LB_BSPC, COMBO_END};
const uint16_t PROGMEM ref_view[] = {KC_U, KC_A, COMBO_END};
const uint16_t PROGMEM term_view[] = {KC_H, KC_L, COMBO_END};

// LAYER SFT base ext
const uint16_t PROGMEM mouse_layer[] = {TH_SPC, LB_BSPC, COMBO_END};
const uint16_t PROGMEM mouse_layer_mo[] = {TH_R, TH_ENT, COMBO_END};
const uint16_t PROGMEM quick_fire_layer[] = {TH_TAB, TH_SPC, COMBO_END};
const uint16_t PROGMEM tmux_layer[] = {TH_SPC, TH_R, TH_ENT, COMBO_END};

// FUNCTIONALITY
// -- core keys
const uint16_t PROGMEM esc_r[] = {KC_H, KC_T, COMBO_END};
const uint16_t PROGMEM esc_l[] = {KC_E, KC_A, COMBO_END};
const uint16_t PROGMEM ent_r[] = {KC_P, KC_F, COMBO_END};
const uint16_t PROGMEM ent_l[] = {KC_I, KC_E, COMBO_END};
const uint16_t PROGMEM stab_r[] = {KC_T, KC_S, KC_N, COMBO_END};
const uint16_t PROGMEM tab_r[] = {KC_T, KC_N, COMBO_END};
const uint16_t PROGMEM spc_r[] = {KC_H, QK_REP, COMBO_END};
const uint16_t PROGMEM spc_l[] = {KC_A, QK_REP, COMBO_END};

// -- modifier
const uint16_t PROGMEM osctl_th[] = {TH_R, TH_SPC, COMBO_END};
const uint16_t PROGMEM osalt_r[] = {KC_G, KC_M, COMBO_END};
const uint16_t PROGMEM ctl_r[] = {TH_TAB, TH_R, COMBO_END};

// -- text mod
const uint16_t PROGMEM bspc_word[] = {KC_I, LB_BSPC, COMBO_END};
const uint16_t PROGMEM caps_word_home[] = {KC_T, KC_E, COMBO_END};
const uint16_t PROGMEM key_del_l[] =   {TH_TAB, LB_BSPC, COMBO_END};
const uint16_t PROGMEM key_del_r[] = {TH_ENT, KC_G, COMBO_END};
const uint16_t PROGMEM del_word[] = {KC_N, KC_G, COMBO_END};
const uint16_t PROGMEM key_home[] = {KC_QUOT, QK_REP, COMBO_END};
const uint16_t PROGMEM key_end[] = {KC_PAST, QK_REP, COMBO_END};

// -- system functions
const uint16_t PROGMEM shutdown[] = {LB_ALTREP, LB_DOT, LB_BSPC, LB_COMM, TH_SPC, COMBO_END};
const uint16_t PROGMEM sleep[] = {LB_ALTREP, LB_DOT, LB_BSPC, LB_COMM, TH_TAB, COMBO_END};
const uint16_t PROGMEM sleep_r[] = {KC_D, KC_T, KC_G, COMBO_END};

// NVIM
const uint16_t PROGMEM nvim_gx[] = {KC_K, KC_H, COMBO_END};
const uint16_t PROGMEM nvim_visual_block[] = {TH_R, KC_D, COMBO_END};
const uint16_t PROGMEM nvim_V[] = {TH_R, KC_L, COMBO_END};
const uint16_t PROGMEM nvim_gv[] = {TH_R, KC_P, COMBO_END};
const uint16_t PROGMEM nvim_gu[] = {TH_R, KC_F, COMBO_END};

// KEYS
const uint16_t PROGMEM key_tilde[] = {TH_SPC, OSM(MOD_LSFT), COMBO_END};
const uint16_t PROGMEM key_bsls[] = {TH_SPC, LB_COMM, COMBO_END};
const uint16_t PROGMEM key_b[] = {TH_R, KC_T, COMBO_END};
const uint16_t PROGMEM key_v[] = {TH_R, KC_H, COMBO_END};
const uint16_t PROGMEM key_j[] = {TH_R, KC_N, COMBO_END};
const uint16_t PROGMEM key_q[] = {TH_R, KC_G, COMBO_END};
const uint16_t PROGMEM key_x[] = {TH_R, KC_S, COMBO_END};
const uint16_t PROGMEM key_z[] = {TH_R, KC_W, COMBO_END};
const uint16_t PROGMEM key_circ[] = {KC_K, TH_R, COMBO_END};
const uint16_t PROGMEM key_dlr[] = {TH_R, KC_M, COMBO_END};
const uint16_t PROGMEM key_perc[] = {TH_ENT, KC_MINS, COMBO_END};
const uint16_t PROGMEM key_ampr[] = {TH_SPC, KC_Y, COMBO_END};
const uint16_t PROGMEM key_pipe[] = {TH_SPC, KC_O, COMBO_END};
const uint16_t PROGMEM key_exlm[] = {TH_SPC, KC_U, COMBO_END};
const uint16_t PROGMEM key_unds[] = {TH_SPC, KC_C, COMBO_END};
const uint16_t PROGMEM key_slsh[] = {TH_SPC, KC_A, COMBO_END};
const uint16_t PROGMEM key_ques[] = {TH_SPC, LB_DOT, COMBO_END};
const uint16_t PROGMEM key_dquo[] = {TH_SPC, KC_I, COMBO_END};
const uint16_t PROGMEM key_coln[] = {KC_E, TH_SPC, COMBO_END};

// XOURNAL
const uint16_t PROGMEM xournal_white[]   = {TH_TAB, KC_E, COMBO_END};
const uint16_t PROGMEM xournal_gray[]    = {TH_TAB, LB_ALTREP, COMBO_END};
const uint16_t PROGMEM xournal_blue[]    = {TH_TAB, LB_DOT, COMBO_END};
const uint16_t PROGMEM xournal_neon[]    = {TH_TAB, LB_BSPC, LB_DOT, COMBO_END};
const uint16_t PROGMEM xournal_yellow[]  = {TH_TAB, LB_COMM, COMBO_END};
const uint16_t PROGMEM xournal_orange[]  = {TH_TAB, KC_Y, COMBO_END};
const uint16_t PROGMEM xournal_red[]     = {TH_TAB, KC_O, COMBO_END};
const uint16_t PROGMEM xournal_magenta[] = {TH_TAB, KC_U, COMBO_END};
const uint16_t PROGMEM xournal_eraser[] =    {TH_TAB, KC_A, COMBO_END};
const uint16_t PROGMEM xournal_select[] =    {TH_TAB, KC_I, COMBO_END};
const uint16_t PROGMEM xournal_rectangle[] = {TH_TAB, KC_C, COMBO_END};
const uint16_t PROGMEM xournal_ellipse[] =   {TH_TAB, OSM(MOD_LSFT), COMBO_END};

combo_t key_combos[78] = {
    // MAIN (30)
    COMBO(ref_view, MOUSE_REF_VIEW),
    COMBO(term_view, TEXT_TERM_VIEW),
    COMBO(mouse_layer, TG(_MOUSE)),
    COMBO(mouse_layer_mo, MO(_MOUSE)),
    COMBO(quick_fire_layer, OSL(_QUICK_FIRE)),
    COMBO(tmux_layer, OSL(_TMUX_FN)),
    COMBO(alt_tab_home, LALT(KC_TAB)),
    COMBO(sup_bspc_home, LGUI(KC_BSPC)),
    COMBO(sup_bspc_left, LGUI(KC_BSPC)),
    COMBO(sup_bspc_left2, LGUI(KC_BSPC)),
    COMBO(sup_tab_thumb, LGUI(KC_TAB)),
    COMBO(sup_tab_left, LGUI(KC_TAB)),
    COMBO(ctl_tab_home, LCTL(KC_TAB)),
    COMBO(bspc_word, BSPC_WORD),
    COMBO(del_word, C(KC_DEL)),
    COMBO(caps_word_home, CW_TOGG),
    COMBO(key_del_l, KC_DEL),
    COMBO(key_del_r, KC_DEL),
    COMBO(nvim_gv, NVIM_GV),
    COMBO(nvim_V, S(KC_V)),
    COMBO(nvim_gx, NVIM_GX),
    COMBO(nvim_visual_block, LCTL(KC_Q)),
    COMBO(nvim_gu, NVIM_GU),
    COMBO(fullscreen_super, LGUI(KC_SPC)),
    COMBO(fullscreen_alt, LALT(KC_SPC)),
    COMBO(spc_r, KC_SPC),
    COMBO(spc_l, KC_SPC),
    COMBO(esc_l, KC_ESC),
    COMBO(esc_r, KC_ESC),
    COMBO(mouse_layer_mo, MO(_MOUSE)),
    COMBO(ent_r, KC_ENT),
    COMBO(ent_l, KC_ENT),
    COMBO(tab_r, KC_TAB),
    COMBO(stab_r, S(KC_TAB)),
    COMBO(osalt_r, OSM(MOD_LALT)),
    COMBO(osctl_th, OSM(MOD_LCTL)),
    COMBO(sleep, KC_SLEP),
    COMBO(sleep_r, KC_SLEP),
    COMBO(shutdown, KC_PWR),
    COMBO(ctl_r, C(KC_R)),

    // KEYS (22)
    COMBO(key_b, KC_B),
    COMBO(key_v, KC_V),
    COMBO(key_x, KC_X),
    COMBO(key_j, KC_J),
    COMBO(key_q, KC_Q),
    COMBO(key_z, KC_Z),
    COMBO(key_bsls, KC_BSLS),
    COMBO(key_unds, KC_UNDS),
    COMBO(key_slsh, KC_SLSH),
    COMBO(key_circ, KC_CIRC),
    COMBO(key_home, KC_HOME),
    COMBO(key_dlr, KC_DLR),
    COMBO(key_end, KC_END),
    COMBO(key_dquo, KC_DQUO),
    COMBO(key_coln, KC_COLN),
    COMBO(key_exlm, KC_EXLM),
    COMBO(key_pipe, KC_PIPE),
    COMBO(key_ampr, KC_AMPR),
    COMBO(key_tilde, KC_TILDE),
    COMBO(key_perc, KC_PERC),
    COMBO(key_ques, KC_QUES),

    // XOURNAL (12)
    COMBO(xournal_white, RCS(KC_D)), // default tool
    COMBO(xournal_select, RCS(KC_R)),
    COMBO(xournal_blue, XOURNAL_BLUE),
    COMBO(xournal_red, XOURNAL_RED),
    COMBO(xournal_yellow, XOURNAL_YELLOW),
    COMBO(xournal_orange, XOURNAL_ORANGE),
    COMBO(xournal_neon, XOURNAL_NEON),
    COMBO(xournal_gray, XOURNAL_GRAY),
    COMBO(xournal_magenta, XOURNAL_MAGENTA),
    COMBO(xournal_eraser, RCS(KC_E)),
    COMBO(xournal_rectangle, XOURNAL_RECT),
    COMBO(xournal_ellipse, XOURNAL_ELLIPSE),
};

/////////////////////////////////////////////////
// MACROS
/////////////////////////////////////////////////

// ^:^ ALTREP SETUP
bool remember_last_key_user(uint16_t keycode, keyrecord_t* record,
                            uint8_t* remembered_mods) {
    switch (keycode) {
        case LB_ALTREP:
        case QK_AREP:
            return false;
    }
    return true;
}

 uint16_t get_alt_repeat_key_keycode_user(uint16_t keycode, uint8_t mods) {
    switch (keycode) {
        case LB_BSPC: return KC_BSPC;
        case KC_Y: return KC_I;
        case KC_B: return KC_R;
        case KC_I: return KC_Y;
        case KC_O: return KC_E;
        case KC_E: return KC_O;
        case KC_A: return KC_U;
        case KC_U: return KC_A;
        case KC_P: return KC_S;
        case KC_W: return KC_N;
        case KC_G: return KC_V;
        case KC_L: return KC_M;
        case KC_M: return KC_P;
        case KC_D: return KC_W;
        case KC_PPLS: return KC_PEQL;
        case MT(MOD_RSFT,KC_MINS): return S(KC_DOT);

        case KC_RIGHT: return KC_SCLN;
        case KC_MINS: return S(KC_DOT);
        case KC_LPRN: return KC_ENT;
        case KC_LCBR: return KC_ENT;
        case KC_LBRC: return KC_ENT;
        case KC_RPRN: return KC_SPC;
        case KC_RCBR: return KC_SPC;
        case KC_RBRC: return KC_SPC;
        case KC_SCLN: return KC_ENT;
        case KC_COLN: return KC_SPC;
        case KC_QUES: return KC_SPC;
        case KC_AMPR: return KC_SPC;
        case KC_SLSH: return KC_SPC;
        case KC_UNDS: return KC_SPC;

        case KC_1: return KC_4;
        case KC_4: return KC_1;
        case KC_2: return KC_5;
        case KC_5: return KC_2;
        case KC_3: return KC_6;
        case KC_6: return KC_3;

        case KC_7: return KC_UP;
        case KC_8: return KC_UP;
        case KC_9: return KC_UP;
        case KC_0: return S(KC_G);
    }
    return false;
}

// HELPER FNS
void tmux(uint16_t keycode) {
    register_code(KC_LCTL);
    tap_code(KC_B);
    unregister_code(KC_LCTL);
    tap_code16(keycode);
}

void tmux_prefix(void) {
    register_code(KC_LCTL);
    tap_code(KC_B);
    unregister_code(KC_LCTL);
}

void tmux_ctrl(uint16_t keycode) {
    register_code(KC_LCTL);
    tap_code16(keycode);
    unregister_code(KC_LCTL);
}

void tmux_close(uint16_t keycode) {
    tmux(keycode);
    tap_code(KC_Y);
}

void activate_pen_mode(uint16_t keycode) {
    register_code(KC_LCTL);
    register_code(KC_LSFT);
    tap_code16(KC_D);
    unregister_code(KC_LCTL);
    unregister_code(KC_LSFT);
    tap_code16(keycode);
}

void activate_default_tool(void) {
  register_code(KC_LCTL);
  register_code(KC_LSFT);
  tap_code16(KC_D);
  unregister_code(KC_LCTL);
  unregister_code(KC_LSFT);
}

bool process_record_user(uint16_t keycode, keyrecord_t* record) {
  switch(keycode) {
    case LB_ALTREP:
      if (record->tap.count) {
        alt_repeat_key_invoke(&record->event);
        return false;
      };
      break;

    case PASTE_AND_POP:
      if (record->event.pressed) {
        register_code(KC_LCTL);
        tap_code(KC_V);
        add_oneshot_mods(MOD_BIT(KC_LALT));
        tap_code(KC_V);
        unregister_code(KC_LCTL);
      }
      break;

    case TEXT_TERM_VIEW:
      if (record->event.pressed) {
        layer_move(_BASE);
        register_code16(MEH(KC_T));   // press MEH+Enter
      } else {
        unregister_code16(MEH(KC_T)); // release MEH+Enter
      }
      return false;

    case MOUSE_REF_VIEW:
      if (record->event.pressed) {
        layer_move(_MOUSE);
        register_code16(MEH(KC_R));   // press MEH+Enter
      } else {
        unregister_code16(MEH(KC_R)); // release MEH+Enter
      }
      return false;

    case END_SCLN_ENT:
      if (record->event.pressed) {
        tap_code(KC_END);
        tap_code(KC_SCLN);
        tap_code(KC_ENT);
      }
    break;

    case MULTILINE_COMMENT:
      if (record->event.pressed) {
        tap_code(KC_SLSH);
        tap_code(KC_PAST);
        tap_code(KC_SPC);
        tap_code(KC_ENT);
        tap_code(KC_ENT);
        tap_code(KC_HOME);
        tap_code(KC_PAST);
        tap_code(KC_SLSH);
        tap_code(KC_UP);
        tap_code(KC_UP);
        tap_code(KC_END);
      }
      break;

    case SPC_PEQL_SPC:
      if (record->event.pressed) {
        tap_code(KC_SPC);
        tap_code(KC_PEQL);
        tap_code(KC_SPC);
      }
      break;

    case SPC_PPLS_SPC:
      if (record->event.pressed) {
        tap_code(KC_SPC);
        tap_code(KC_PPLS);
        tap_code(KC_SPC);
      }
      break;

    case CODEBLOCKS:
      if (record->event.pressed) {
        tap_code(KC_GRV);
        tap_code(KC_GRV);
        tap_code(KC_GRV);
        tap_code(KC_DEL);
        tap_code(KC_ENT);
        tap_code(KC_ENT);
        tap_code(KC_HOME);
        tap_code(KC_GRV);
        tap_code(KC_GRV);
        tap_code(KC_GRV);
        tap_code(KC_DEL);
        tap_code(KC_UP);
        tap_code(KC_UP);
      }
      break;

    case BSPC_WORD:
      if (record->event.pressed) {
        add_oneshot_mods(MOD_BIT(KC_LCTL));
        tap_code(KC_BSPC);
      }
      break;

    // NVIM
    case NVIM_STAGE_LINE:
      if (record->event.pressed) {
        tap_code(KC_D);
        tap_code(KC_M);
        tap_code(KC_MINS);
     }
     break;

    case NVIM_GX:
      if (record->event.pressed) {
        tap_code(KC_G);
        tap_code(KC_X);
      }
      break;

    case NVIM_PREV_HUNK:
      if (record->event.pressed) {
        tap_code(KC_LBRC);
        tap_code(KC_H);
      }
      break;

    case NVIM_STAGE_HUNK:
      if (record->event.pressed) {
        tap_code(KC_G);
        tap_code(KC_H);
        tap_code(KC_G);
        tap_code(KC_H);
      }
      break;

    case NVIM_RESET_HUNK:
      if (record->event.pressed) {
        tap_code(KC_G);
        add_oneshot_mods(MOD_BIT(KC_LSFT));
        tap_code(KC_H);
        tap_code(KC_G);
        add_oneshot_mods(MOD_BIT(KC_LSFT));
        tap_code(KC_H);
      }
      break;

    case NVIM_YANK_REG_PASTE:
      if (record->event.pressed) {
        tap_code16(KC_DQUO);
        tap_code(KC_0);
        tap_code(KC_P);
      }
      break;

    case NVIM_NEXT_HUNK:
      if (record->event.pressed) {
        tap_code(KC_RBRC);
        tap_code(KC_H);
      }
      break;

    case NVIM_VIP:
      if (record->event.pressed) {
        tap_code(KC_V);
        tap_code(KC_I);
        tap_code(KC_P);
      }
      break;

    case NVIM_GU:
      if (record->event.pressed) {
        tap_code(KC_G);
        add_oneshot_mods(MOD_BIT(KC_LSFT));
        tap_code(KC_U);
      }
      break;

    case NVIM_GV:
      if (record->event.pressed) {
        tap_code(KC_G);
        tap_code(KC_V);
      }
      break;

    // XOURNAL
    case XOURNAL_GRAY:
      if (record->event.pressed) {
        activate_pen_mode(KC_6);
      }
      return false;

    case XOURNAL_BLUE:
      if (record->event.pressed) {
        activate_pen_mode(KC_3);
      }
      return false;

    case XOURNAL_NEON:
      if (record->event.pressed) {
        activate_pen_mode(KC_4);
      }
      return false;

    case XOURNAL_YELLOW:
      if (record->event.pressed) {
        activate_pen_mode(KC_9);
      }
      return false;

    case XOURNAL_ORANGE:
      if (record->event.pressed) {
        activate_pen_mode(KC_8);
      }
      return false;

    case XOURNAL_RED:
      if (record->event.pressed) {
        activate_pen_mode(KC_7);
      }
      return false;

    case XOURNAL_MAGENTA:
      if (record->event.pressed) {
        activate_pen_mode(KC_0);
      }
      return false;

    case XOURNAL_ELLIPSE:
      if (record->event.pressed) {
        activate_default_tool();
        add_oneshot_mods(MOD_BIT(KC_LCTL));
        tap_code(KC_3);
      }
      return false;

    case XOURNAL_RECT:
      if (record->event.pressed) {
        activate_default_tool();
        add_oneshot_mods(MOD_BIT(KC_LCTL));
        tap_code(KC_2);
      }
      return false;

    // TMUX
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

    case TM_RN_WIN:
      if (record->event.pressed) {
        tmux(KC_COMM);
      }
      return false;

    case TM_RN_SESS:
      if (record->event.pressed) {
        tmux(KC_DLR);
      }
      return false;

    case TM_PREV_SESS:
      if (record->event.pressed)  {
        tmux(KC_LPRN);
      }
      return false;

    case TM_SESS_MANAGER:
      if (record->event.pressed) {
        tmux(KC_S);
      }
      return false;

    case TM_SAVE:
      if (record->event.pressed) {
        tmux_prefix();
        tmux_ctrl(KC_S);
      }
      return false;

    case TM_RESTORE:
      if (record->event.pressed) {
        tmux_prefix();
        tmux_ctrl(KC_R);
      }
      return false;
  }
  return true;
};

/////////////////////////////////////////////////
// KEYMAPS
/////////////////////////////////////////////////
/*
FLOATING SYMBOLS
- symbols not found in the symbols layer
- ?\/_:"

BASE SYMBOLS
- '-;
*/

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
  [_BASE] = LAYOUT_split_3x5_2(KC_SCLN, KC_Y, KC_O, KC_U, KC_QUOT, KC_PAST, KC_L, KC_D, KC_P, KC_F, KC_C, KC_I, KC_E, KC_A, QK_REP, QK_REP, KC_H, KC_T, KC_N, KC_S, OSM(MOD_RSFT), LB_DOT, LB_BSPC, LB_COMM, QK_ALT_REPEAT_KEY, KC_K, KC_M, KC_G, KC_W, RB_MINS, TH_TAB, TH_SPC, TH_R, TH_SCRAPS),

  [_SCRAPS] = LAYOUT_split_3x5_2(KC_COLN, KC_TRNS, KC_TRNS, KC_TRNS, KC_QUES, KC_TRNS, KC_TRNS, KC_Q, KC_TRNS, KC_Z, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_V, KC_B, KC_J, KC_X, KC_UNDS, KC_TRNS, C(KC_BSPC), KC_R, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS),

  [_SYMBOLS] = LAYOUT_split_3x5_2(KC_TRNS, KC_AMPR, KC_PIPE, KC_EXLM, KC_GRV, KC_TILDE, KC_PMNS, KC_EQL, KC_PPLS, KC_DEL, S(KC_COMM), KC_LCBR, KC_LPRN, KC_LBRC, KC_TRNS, KC_TRNS, KC_RBRC, KC_RPRN, KC_RCBR, S(KC_DOT), KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_CIRC, KC_DLR, KC_HASH, KC_AT, KC_BSLS, KC_ENT, KC_TRNS, KC_TRNS, KC_TRNS),

  [_ARROW_NUMPAD] = LAYOUT_split_3x5_2(KC_SPC, KC_7, KC_8, KC_9, KC_DQUO, KC_TRNS, KC_MINS, KC_EQL, KC_PPLS, KC_RIGHT, KC_LEFT, KC_DOWN, KC_UP, KC_RIGHT, QK_REP, QK_REP, KC_1, KC_2, KC_3, KC_0, KC_UNDS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, S(KC_G), KC_4, KC_5, KC_6, KC_TRNS, KC_TRNS, KC_TRNS, C(KC_LEFT), C(KC_RIGHT)),

  [_QUICK_FIRE] = LAYOUT_split_3x5_2(KC_MUTE, KC_VOLD, KC_VOLU, MEH(KC_T), LCA(KC_TAB), MULTILINE_COMMENT, CODEBLOCKS, SPC_PEQL_SPC, SPC_PPLS_SPC, END_SCLN_ENT, PASTE_AND_POP, A(KC_LEFT), A(KC_RIGHT), LCA(KC_SPC), QK_REP, QK_REP, A(KC_1), A(KC_2), A(KC_3), NVIM_YANK_REG_PASTE, C(KC_Z), C(KC_X), C(KC_C), C(KC_V), RCS(KC_H), KC_F12, A(KC_4), A(KC_5), TM_PREV_SESS, TM_SESS_MANAGER, KC_TRNS, KC_TRNS, KC_WH_D, KC_WH_U),

  [_QUICK_FIRE] = LAYOUT_split_3x5_2(KC_MUTE, KC_VOLD, KC_VOLU, G(KC_SCLN), LSG(KC_R), TM_RN_WIN, TM1, TM2, TM3, TM4, PASTE_AND_POP, A(KC_LEFT), A(KC_RIGHT), LSG(KC_S), QK_REP, QK_REP, A(KC_1), A(KC_2), A(KC_3), TM_PANEV_NEW, C(KC_Z), C(KC_X), C(KC_C), C(KC_V), RCS(KC_H), TM_WIN_NEW, A(KC_4), A(KC_5), A(KC_6), TM_PANE_CLOSE, KC_TRNS, KC_TRNS, KC_WH_D, KC_WH_U),

  [_TMUX_FN] = LAYOUT_split_3x5_2(NVIM_STAGE_HUNK, KC_F7, KC_F8, KC_F9, KC_F10, TM_RN_SESS, TM_RESTORE, TM_SAVE, TM_RELOAD, QK_BOOT, NVIM_RESET_LINE, NVIM_PREV_HUNK, NVIM_NEXT_HUNK, NVIM_STAGE_LINE, KC_F11, KC_F12, KC_F1, KC_F2, KC_F3, TM_PANEH_NEW, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, CG_TOGG, KC_TRNS, KC_F4, KC_F5, KC_F6, TM_PANE_CLOSE, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS),
};

// DEPRECATED
// #define TMUX_CASE(code , key) case code: tmux(key); return false;
