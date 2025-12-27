#include QMK_KEYBOARD_H
/////////////////////////////////////////////////
// OVERVIEW
/////////////////////////////////////////////////

enum layers {
  _T_BASE,
  _T_SCRAPS,
  _SYMBOLS,
  _FLOW_SYMBOLS,
  _ARROWS_NUMPAD,
  _MOUSE_7SYMBOLS,
  _QUICK_FIRE,
  _FN,
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
  TM_RELOAD,
  TM1,
  TM2,
  TM3,
  TM4,

  // XOURNAL
  XOURNAL_BLACK,
  XOURNAL_YELLOW,
  XOURNAL_ORANGE,
  XOURNAL_CYAN,
  XOURNAL_NEON,
  XOURNAL_GRAY,
  XOURNAL_RECT,
  XOURNAL_HIGHLIGHTER,

  FIG_MARKER,
  FIG_MOVE,
  FIG_ERASE,
  FIG_HIGHLIGHT,

  // NVIM
  NV_ZZ,
  NV_PREV_HUNK,
  NV_NEXT_HUNK,
  NV_STAGE_HUNK,
  NV_RESET_LINE,
  NV_STAGE_LINE,
  NV_MIDLINE,
  NV_YANK_REGISTER,
  NV_A_REGISTER,
  VISUAL_LINE,
  NV_MAKE_GMARK,
  NV_GOTO_GMARK,
  NV_HIGH_LINE,

  // COMMON SYNERGIES
  EXLM_EQL,
  MULTILINE_COMMENT,
  RIGHT_DELETE,
  SPC_EQL_SPC,
  END_SCLN_ENT,
  CODEBLOCKS,

  // SYSTEM
  MOUSE_REF_VIEW,
  SYS_DUPLICATE,
  TEXT_TERM_VIEW,
  TEXT_REF_VIEW,
  PASTE_AND_POP, // uses a custom shell script
  DEL_WORD,
};

/////////////////////////////////////////////////
// VARIABLES
/////////////////////////////////////////////////
// THUMB
#define TH_TAB MT(MOD_LCTL, KC_TAB)
#define TH_SCRAPS OSL(_T_SCRAPS)
#define TH_SPC LT(_ARROWS_NUMPAD, KC_SPC)
#define TH_R LT(_MOUSE_7SYMBOLS, KC_R)

// LEFT BOT & RIGHT
// #define LB_SFT MT(MOD_LSFT, KC_0)
#define LB_DOT MT(MOD_LCTL, KC_DOT)
#define LB_BSPC MT(MOD_LALT, KC_BSPC)
#define LB_COMM MT(MOD_LGUI, KC_COMM)
#define LB_SFT OSM(MOD_LSFT)

// LAYER SPECIFIC KEYS
#define SUPER2 MT(MOD_RGUI, KC_2)
#define SFT0 MT(MOD_RSFT, KC_0)
#define CTL3 MT(MOD_RCTL, KC_3)
#define CTL_SPC MT(MOD_LCTL, KC_SPC)

// NAV KEYS
#define SYS_FULLSCREEN KC_F11
#define APP_FULLSCREEN A(KC_SPC)
#define APP_TOGGLE A(KC_C)
#define SYS_TOGGLE A(KC_TAB)
#define TAB_TOGGLE C(KC_TAB)
#define STAB_TOGGLE RCS(KC_TAB)
#define NV_PANE_TOGGLE C(KC_T)
#define MON1_TOGGLE G(KC_TAB)
#define MON2_TOGGLE G(KC_E)
#define APPLICATION_LAUNCHER G(KC_S)
#define CLOSE_WINDOW C(KC_W)
#define CLOSE_SYS_WINDOW A(KC_F4)

#define SCREENSHOT LSG(KC_S)
#define SCREENSHOT_OCR LSG(KC_O)
#define ZOOM_IN C(KC_PPLS)
#define ZOOM_OUT C(KC_PMNS)
#define CLIPBOARD G(KC_V)
#define EMOJIS G(KC_SCLN)
#define GO_BACK A(KC_LEFT)
#define GO_FORWARD A(KC_RIGHT)
#define MOVE_LEFT_WORD C(KC_LEFT)
#define MOVE_RIGHT_WORD C(KC_RIGHT)

#define LABRC S(KC_COMM)
#define RABRC S(KC_DOT)

/////////////////////////////////////////////////
// CONFIG
/////////////////////////////////////////////////
// NOTE: For faster access to non-texts (nums and symbols), I reduced the tap-term drastically for R and SPC. Don't linger when you press R and SPC unless you want to access (nums and symbols)!

uint16_t get_tapping_term(uint16_t keycode, keyrecord_t *record) {
  switch (keycode) {
    case TH_R:
      return 150; // Sets a specific, shorter time
    case TH_SPC:
      return 150;
    case OSL(_SYMBOLS):
      return 0;
    case MT(MOD_LCTL, KC_SPC):
    case SUPER2:
    case SFT0:
    case CTL3:
      return 250;
    default:
      return TAPPING_TERM; // Uses the default for all other keys
  }
}

/////////////////////////////////////////////////
// COMBOS
/////////////////////////////////////////////////
// NAV
const uint16_t PROGMEM app_toggle_l[] = {QK_REP, KC_A, COMBO_END};
const uint16_t PROGMEM sys_full[] = {TH_SPC, TH_TAB, KC_I, COMBO_END};
const uint16_t PROGMEM sys_toggle[] = {TH_SPC, TH_TAB, LB_BSPC, COMBO_END};

const uint16_t PROGMEM mon1_l[] = {KC_I, KC_E, KC_A, COMBO_END};
const uint16_t PROGMEM mon1_r[] = {KC_H, KC_T, KC_N, COMBO_END};
const uint16_t PROGMEM mon2_l[] = {KC_I, KC_E, LB_COMM, COMBO_END};
const uint16_t PROGMEM mon2_r[] = {KC_M, KC_T, KC_N, COMBO_END};
const uint16_t PROGMEM tm_session_toggle[] = {QK_REP, KC_A, KC_E, COMBO_END};
const uint16_t PROGMEM app_full[] = {TH_TAB, TH_SPC, KC_A, COMBO_END};

const uint16_t PROGMEM ref_view[] = {KC_A, KC_U, COMBO_END};
const uint16_t PROGMEM ref_view_text_layer[] = {KC_U, KC_E, KC_A, COMBO_END};

const uint16_t PROGMEM term_view_l[] = {KC_O, KC_E, KC_A, COMBO_END};
const uint16_t PROGMEM term_view[] = {KC_H, KC_L, COMBO_END};

const uint16_t PROGMEM base_layer[] = {KC_G, KC_M, COMBO_END};
const uint16_t PROGMEM mouse_layer_l[] = {KC_QUOT, KC_Y, COMBO_END};
const uint16_t PROGMEM symbol_layer[] = {TH_R, TH_SCRAPS, COMBO_END};
const uint16_t PROGMEM quick_fire_layer[] = {TH_TAB, TH_SPC, COMBO_END};
const uint16_t PROGMEM fn_layer[] = {TH_TAB, TH_SPC, TH_R, TH_SCRAPS, COMBO_END};


// SYS FUNCTIONALITY
const uint16_t PROGMEM close_window[] = {LB_BSPC, LB_DOT, COMBO_END};
const uint16_t PROGMEM close_frame[] = {LB_COMM, LB_DOT, COMBO_END};
const uint16_t PROGMEM shutdown[] = {LB_SFT, LB_DOT, LB_BSPC, LB_COMM, TH_SPC, COMBO_END};
const uint16_t PROGMEM sleep[] = {LB_SFT, LB_DOT, LB_BSPC, LB_COMM, TH_TAB, COMBO_END};
const uint16_t PROGMEM zoom_in[] = {KC_A, KC_E, TH_SPC, COMBO_END};
const uint16_t PROGMEM zoom_out[] = {KC_I, KC_E, TH_SPC, COMBO_END};

// -- clipboard
const uint16_t PROGMEM sys_clipboard[]    = {TH_TAB, LB_COMM, COMBO_END};
const uint16_t PROGMEM sys_copy[]    = {TH_TAB, KC_E, COMBO_END};
const uint16_t PROGMEM sys_paste[]  = {TH_TAB, KC_I, COMBO_END};
const uint16_t PROGMEM sys_paste_pop[]  = {TH_TAB, KC_C, COMBO_END};
const uint16_t PROGMEM sys_redo[] = {TH_TAB, QK_REP, COMBO_END};
const uint16_t PROGMEM sys_undo[]  = {TH_TAB, KC_A, COMBO_END};
const uint16_t PROGMEM sys_screenshot[]  = {TH_SPC, TH_TAB, KC_E, COMBO_END};
const uint16_t PROGMEM sys_screenshot_ocr[]  = {TH_SPC, TH_TAB, KC_O, COMBO_END};


// SHORTCUTS
// ctl
const uint16_t PROGMEM ctl_l[] = {TH_R, KC_H, COMBO_END};
const uint16_t PROGMEM ctl_t[] = {TH_R, KC_T, COMBO_END};
const uint16_t PROGMEM ctl_n[] = {TH_R, KC_N, COMBO_END};
const uint16_t PROGMEM ctl_r[] = {TH_R, KC_M, COMBO_END};
const uint16_t PROGMEM ctl_a[] = {TH_R, KC_A, COMBO_END};

// text edit: general
const uint16_t PROGMEM del_word[] = {QK_REP, KC_H, COMBO_END};
const uint16_t PROGMEM caps_word[] = {KC_D, KC_T, COMBO_END};
const uint16_t PROGMEM k_del_ltab[] =   {TH_TAB, LB_BSPC, COMBO_END};
const uint16_t PROGMEM k_del_lspc[] =   {TH_SPC, LB_BSPC, COMBO_END};
const uint16_t PROGMEM select_line[] = {QK_REP, KC_H, KC_T, COMBO_END};

// text edit: nvim
const uint16_t PROGMEM visual_block[] = {TH_R, KC_N, TH_SCRAPS, COMBO_END};
const uint16_t PROGMEM nv_highlight_line[] = {TH_R, TH_SCRAPS, KC_H, COMBO_END};
const uint16_t PROGMEM nv_goto_gmark[] = {TH_SCRAPS, KC_G, COMBO_END};
const uint16_t PROGMEM nv_make_gmark[] = {TH_SCRAPS, KC_M, COMBO_END};
const uint16_t PROGMEM nv_0_reg_ins[] = {TH_SCRAPS, KC_D, COMBO_END};
const uint16_t PROGMEM nv_a_reg_ins[] = {TH_SCRAPS, KC_L, COMBO_END};
const uint16_t PROGMEM nv_midline[] = {KC_H, QK_REP, KC_A, COMBO_END};
const uint16_t PROGMEM nv_zz[] = {KC_T, TH_SCRAPS, TH_R, COMBO_END};
const uint16_t PROGMEM spc_eql_spc[] = {KC_G, KC_W, COMBO_END};
const uint16_t PROGMEM codeblocks[] = {TH_R, KC_PAST, COMBO_END};

// xournal
const uint16_t PROGMEM xournal_white[]   = {TH_TAB, KC_I, KC_A, KC_E, COMBO_END};
const uint16_t PROGMEM xournal_highlighter[]  = {TH_TAB, KC_I, KC_A, COMBO_END};
const uint16_t PROGMEM xournal_eraser[] =    {TH_TAB, KC_I, KC_E, COMBO_END};
const uint16_t PROGMEM xournal_select[] =    {TH_TAB, KC_A, KC_E, COMBO_END};

const uint16_t PROGMEM fig_highlight[] = {TH_TAB, KC_Y, KC_U, COMBO_END};
const uint16_t PROGMEM fig_marker[] = {TH_TAB, KC_O, COMBO_END};
const uint16_t PROGMEM fig_move[] = {TH_TAB, KC_U, COMBO_END};
const uint16_t PROGMEM fig_erase[] = {TH_TAB, KC_Y, COMBO_END};

// KEYS
// core
// for the sake of convenience, I have to sacrifice the nt and ea bigrams.
const uint16_t PROGMEM ctl_th[] = {TH_R, TH_SPC, COMBO_END};
const uint16_t PROGMEM ctlsft_th[] = {TH_TAB, TH_SCRAPS, COMBO_END};

const uint16_t PROGMEM esc_r[] = {KC_H, KC_T, COMBO_END};
const uint16_t PROGMEM esc_l[] = {KC_E, KC_A, COMBO_END};
const uint16_t PROGMEM ent_r[] = {KC_T, KC_N, COMBO_END};
const uint16_t PROGMEM ent_l[] = {KC_I, KC_E, COMBO_END};
const uint16_t PROGMEM spc_r[] = {KC_H, KC_N, COMBO_END};
const uint16_t PROGMEM tab_r[] = {KC_T, KC_N, TH_R, COMBO_END};
const uint16_t PROGMEM stab_r[] = {KC_T, KC_H, TH_R, COMBO_END};

const uint16_t PROGMEM k_home[] = {TH_SCRAPS, KC_T, KC_H, COMBO_END};
const uint16_t PROGMEM k_end[] = {TH_SCRAPS, KC_T, KC_N, COMBO_END};
const uint16_t PROGMEM k_scln[] = {TH_SPC, KC_I, COMBO_END};
const uint16_t PROGMEM k_unds[] = {TH_SPC, KC_C, COMBO_END};
const uint16_t PROGMEM k_slsh[] = {TH_SPC, KC_A, COMBO_END};
const uint16_t PROGMEM k_coln[] = {KC_E, TH_SPC, COMBO_END};
const uint16_t PROGMEM k_ques[] = {KC_PAST, QK_REP, COMBO_END};
const uint16_t PROGMEM k_exlm[] = {KC_MINS, QK_REP, COMBO_END};

  // autopair synergies (with left and right)
const uint16_t PROGMEM k_q[] = {TH_SCRAPS, KC_W, COMBO_END};
const uint16_t PROGMEM k_v[] = {TH_SCRAPS, KC_H, COMBO_END};
const uint16_t PROGMEM k_z[] = {TH_SCRAPS, KC_F, COMBO_END};
const uint16_t PROGMEM k_b[] = {TH_SCRAPS, KC_T, COMBO_END};
const uint16_t PROGMEM k_j[] = {TH_SCRAPS, KC_N, COMBO_END};
const uint16_t PROGMEM k_x[] = {TH_SCRAPS, KC_S, COMBO_END};


combo_t key_combos[92] = {
    // TOGGLE
    COMBO(app_toggle_l, APP_TOGGLE),
    COMBO(sys_full, SYS_FULLSCREEN),
    COMBO(sys_toggle, SYS_TOGGLE),
    COMBO(app_full, APP_FULLSCREEN),
    COMBO(mon1_l, MON1_TOGGLE),
    COMBO(mon1_r, MON1_TOGGLE),
    COMBO(mon2_l, MON2_TOGGLE),
    COMBO(mon2_r, MON2_TOGGLE),
    COMBO(tm_session_toggle, TM_PREV_SESS),

    // SYS
    COMBO(sys_clipboard, CLIPBOARD),
    COMBO(sys_copy, C(KC_C)),
    COMBO(sys_paste, C(KC_V)),
    COMBO(sys_paste_pop, PASTE_AND_POP),
    COMBO(sys_screenshot, SCREENSHOT),
    COMBO(sys_screenshot_ocr, SCREENSHOT_OCR),
    COMBO(sys_undo, C(KC_Z)),
    COMBO(sys_redo, C(KC_Y)),
    COMBO(close_window, CLOSE_WINDOW),
    COMBO(close_frame, CLOSE_SYS_WINDOW),
    COMBO(ref_view_text_layer, TEXT_REF_VIEW),
    COMBO(ref_view, MOUSE_REF_VIEW),
    COMBO(term_view_l, TEXT_TERM_VIEW),
    COMBO(term_view, TEXT_TERM_VIEW),
    COMBO(sleep, KC_SLEP),
    COMBO(shutdown, KC_PWR),
    COMBO(zoom_in, ZOOM_IN),
    COMBO(zoom_out, ZOOM_OUT),

    // Layer
    COMBO(symbol_layer, MO(_SYMBOLS)),
    COMBO(mouse_layer_l, TG(_MOUSE_7SYMBOLS)),
    COMBO(base_layer, TO(_T_BASE)),
    COMBO(quick_fire_layer, OSL(_QUICK_FIRE)),
    COMBO(fn_layer, MO(_FN)),

    // TEXT MANIPULATION
    COMBO(del_word, DEL_WORD),
    COMBO(caps_word, CW_TOGG),

    // COMBO KEYS
    COMBO(ctlsft_th, OSM(MOD_LCTL | MOD_LSFT)),
    COMBO(ctl_th, OSM(MOD_LCTL)),
    COMBO(ctl_n, C(KC_N)),
    COMBO(ctl_a, C(KC_A)),
    COMBO(ctl_r, C(KC_R)),
    COMBO(ctl_l, C(KC_L)),
    COMBO(ctl_t, C(KC_T)),

    // TEXT MANIPULATION
    COMBO(nv_0_reg_ins, NV_YANK_REGISTER),
    COMBO(nv_a_reg_ins, NV_A_REGISTER),
    COMBO(nv_zz, NV_ZZ),
    COMBO(nv_midline, NV_MIDLINE),
    COMBO(spc_eql_spc, SPC_EQL_SPC),
    COMBO(codeblocks, CODEBLOCKS),
    COMBO(select_line, VISUAL_LINE),
    COMBO(nv_make_gmark, NV_MAKE_GMARK),
    COMBO(nv_goto_gmark, NV_GOTO_GMARK),
    COMBO(nv_highlight_line, NV_HIGH_LINE),
    COMBO(visual_block, C(KC_Q)),

    // KEYS 23
    COMBO(esc_l, KC_ESC),
    COMBO(esc_r, KC_ESC),
    COMBO(ent_r, KC_ENT),
    COMBO(ent_l, KC_ENT),
    COMBO(tab_r, KC_TAB),
    COMBO(spc_r, KC_SPC),
    COMBO(stab_r, S(KC_TAB)),

    COMBO(k_home, KC_HOME),
    COMBO(k_end, KC_END),
    COMBO(k_del_ltab, KC_DEL),
    COMBO(k_del_lspc, KC_DEL),
    COMBO(k_scln, KC_SCLN),

    COMBO(k_unds, KC_UNDS),
    COMBO(k_slsh, KC_SLSH),
    COMBO(k_coln, KC_COLN),
    COMBO(k_ques, KC_QUES),
    COMBO(k_exlm, KC_EXLM),

    COMBO(k_q, KC_Q),
    COMBO(k_v, KC_V),
    COMBO(k_z, KC_Z),
    COMBO(k_b, KC_B),
    COMBO(k_j, KC_J),
    COMBO(k_x, KC_X),

    // XOURNAL (14)
    COMBO(xournal_white, RCS(KC_D)), // default tool
    COMBO(xournal_select, RCS(KC_R)),
    COMBO(xournal_eraser, RCS(KC_E)),
    COMBO(xournal_highlighter, XOURNAL_HIGHLIGHTER),

    COMBO(fig_highlight, FIG_HIGHLIGHT),
    COMBO(fig_marker, FIG_MARKER),
    COMBO(fig_erase, FIG_ERASE),
    COMBO(fig_move, FIG_MOVE),
};

/////////////////////////////////////////////////
// MACROS
///////////////////////
// ^:^ ALTREP SETUP
bool remember_last_key_user(uint16_t keycode, keyrecord_t* record,
                            uint8_t* remembered_mods) {
    switch (keycode) {
        case OSM(MOD_RSFT):
        case QK_AREP:
            return false;
    }
    return true;
}

 uint16_t get_alt_repeat_key_keycode_user(uint16_t keycode, uint8_t mods) {
    switch (keycode) {
        case KC_B: return KC_R;
        case KC_X: return KC_T;
        case TH_R: return KC_B;
        case KC_E: return KC_O;
        case KC_A: return KC_U;
        case KC_U: return KC_A;
        case KC_W: return KC_N;
        case KC_L: return KC_M;
        case KC_M: return KC_H; // useful for making h mark
        case KC_D: return KC_W;
        case KC_Z: return KC_F;
        case KC_PMNS: return RABRC;
        case KC_MINS: return RABRC;
        case KC_PEQL: return RABRC;
        case KC_COLN: return KC_SPC;
        case KC_SCLN: return KC_SPC;
        case KC_AMPR: return KC_SPC;
        case KC_SLSH: return KC_SPC;

        case KC_1: return KC_4;
        case KC_4: return KC_1;
        case KC_2: return KC_5;
        case KC_5: return KC_2;
        case KC_3: return KC_6;
        case KC_6: return KC_3;

        case KC_LBRC: return KC_RBRC;
        case KC_LCBR: return KC_RCBR;
        case KC_LPRN: return KC_RPRN;
        case KC_RBRC: return KC_SCLN;
        case KC_RCBR: return KC_SCLN;
        case KC_RPRN: return KC_SCLN;

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

void pen_mode_color(uint16_t keycode) {
    register_code(KC_LCTL);
    register_code(KC_LSFT);
    tap_code16(KC_D);
    unregister_code(KC_LCTL);
    unregister_code(KC_LSFT);
    tap_code16(keycode);
}

void shape_tool(void) {
  register_code(KC_LCTL);
  register_code(KC_LSFT);
  tap_code16(KC_P);
  unregister_code(KC_LCTL);
  unregister_code(KC_LSFT);
}

bool process_record_user(uint16_t keycode, keyrecord_t* record) {
  switch(keycode) {

    case PASTE_AND_POP:
      if (record->event.pressed) {
        register_code(KC_LCTL);
        tap_code(KC_V);
        add_oneshot_mods(MOD_BIT(KC_LALT));
        tap_code(KC_V);
        unregister_code(KC_LCTL);
      }
      break;

    case MOUSE_REF_VIEW:
      if (record->event.pressed) {
        layer_move(_MOUSE_7SYMBOLS);
        register_code(KC_LCTL);
        register_code(KC_LGUI);
        tap_code(KC_LEFT);
        unregister_code(KC_LGUI);
        unregister_code(KC_LCTL);
      }
      return false;

    case TEXT_REF_VIEW:
      if (record->event.pressed) {
        layer_move(_T_BASE);
        register_code(KC_LCTL);
        register_code(KC_LGUI);
        tap_code(KC_LEFT);
        unregister_code(KC_LGUI);
        unregister_code(KC_LCTL);
      }
      return false;

    case TEXT_TERM_VIEW:
      if (record->event.pressed) {
        layer_move(_T_BASE);
        register_code(KC_LCTL);
        register_code(KC_LGUI);
        tap_code(KC_RIGHT);
        unregister_code(KC_LGUI);
        unregister_code(KC_LCTL);
      }
      return false;

    case NV_MAKE_GMARK:
    if (record->event.pressed) {
        tap_code(KC_M);
        set_oneshot_mods(MOD_BIT(KC_LSFT));
      }
    return false;

    case NV_HIGH_LINE:
      if (record->event.pressed) {
        tap_code16(S(KC_V));
        tap_code(KC_T);
        tap_code(KC_ENT);
      }
      return false;

    case NV_MIDLINE:
      if (record->event.pressed) {
        tap_code(KC_G);
        tap_code16(S(KC_M));
      }
      return false;

    case NV_ZZ:
      if (record->event.pressed) {
        tap_code(KC_Z);
        tap_code(KC_Z);
      }
      return false;

    case NV_GOTO_GMARK:
      if (record->event.pressed) {
        tap_code(KC_QUOT);
        set_oneshot_mods(MOD_BIT(KC_LSFT));
      }
      return false;

    case VISUAL_LINE:
      if (record->event.pressed) {
        tap_code(KC_HOME);
        add_oneshot_mods(MOD_BIT(KC_LSFT));
        tap_code(KC_END);
      }
    break;

    case SPC_EQL_SPC:
      if (record->event.pressed) {
        tap_code(KC_SPC);
        tap_code(KC_EQL);
        tap_code(KC_SPC);
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

    case DEL_WORD:
      if (record->event.pressed) {
        add_oneshot_mods(MOD_BIT(KC_LCTL));
        tap_code(KC_BSPC);
      }
      break;

    case NV_STAGE_LINE:
      if (record->event.pressed) {
        add_oneshot_mods(MOD_BIT(KC_LSFT));
        tap_code(KC_V);
        tap_code(KC_G);
        tap_code(KC_H);
     }
     break;

    case NV_PREV_HUNK:
      if (record->event.pressed) {
        tap_code(KC_LBRC);
        tap_code(KC_H);
      }
      break;

    case NV_STAGE_HUNK:
      if (record->event.pressed) {
        tap_code(KC_G);
        tap_code(KC_H);
        tap_code(KC_G);
        tap_code(KC_H);
      }
      break;

    case NV_RESET_LINE:
      if (record->event.pressed) {
        add_oneshot_mods(MOD_BIT(KC_LSFT));
        tap_code(KC_V);
        tap_code(KC_G);
        add_oneshot_mods(MOD_BIT(KC_LSFT));
        tap_code(KC_H);
        tap_code(KC_DOWN);
      }
      break;

  // NVIM REGISTERS
    case NV_A_REGISTER:
      if (record->event.pressed) {
        add_oneshot_mods(MOD_BIT(KC_LCTL));
        tap_code(KC_R);
        tap_code16(KC_A);
      }
      break;

    case NV_YANK_REGISTER:
      if (record->event.pressed) {
        add_oneshot_mods(MOD_BIT(KC_LCTL));
        tap_code(KC_R);
        tap_code(KC_0);
      }
      break;


    case NV_NEXT_HUNK:
      if (record->event.pressed) {
        tap_code(KC_RBRC);
        tap_code(KC_H);
      }
      break;

    // XOURNAL
    case XOURNAL_HIGHLIGHTER:
      if (record->event.pressed) {
        add_oneshot_mods(MOD_BIT(KC_LCTL));
        add_oneshot_mods(MOD_BIT(KC_LSFT));
        tap_code(KC_H);
      }
      return false;

    case FIG_HIGHLIGHT:
      if (record->event.pressed) {
        add_oneshot_mods(MOD_BIT(KC_LSFT));
        tap_code(KC_M);
      }
      return false;

    case FIG_MOVE:
      if (record->event.pressed) {
        tap_code(KC_V);
      }
      return false;

    case FIG_ERASE:
      if (record->event.pressed) {
        add_oneshot_mods(MOD_BIT(KC_LSFT));
        tap_code(KC_DEL);
      }
      return false;

    case FIG_MARKER:
      if (record->event.pressed) {
        tap_code(KC_M);
      }
      return false;

    // TMUX
    case TM1:
      tmux(KC_1);
      return false; // Tells QMK not to process TM1 further
    case TM2:
      tmux(KC_2);
      return false;
    case TM3:
      tmux(KC_3);
      return false;
    case TM4:
      tmux(KC_4);
      return false;

    case TM_WIN_NEW:
      if (record->event.pressed) {
        tmux(KC_C);
        tmux(KC_PERC);
      }
      return false;

    case TM_RELOAD:
      if (record->event.pressed) {
        tmux(KC_R);
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
    if (record->event.pressed) {
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
// T/B=top,bot | L/R=left,right

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
  // :✅
  [_T_BASE] = LAYOUT_split_3x5_2(KC_QUOT, KC_Y, KC_O, KC_U, KC_MINS, KC_PAST, KC_L, KC_D, KC_P, KC_F, KC_C, KC_I, KC_E, KC_A, QK_REP, QK_REP, KC_H, KC_T, KC_N, KC_S, LB_SFT, LB_DOT, LB_BSPC, LB_COMM, QK_AREP, KC_K, KC_M, KC_G, KC_W, LB_SFT, TH_TAB, TH_SPC, TH_R, TH_SCRAPS),

  [_T_SCRAPS] = LAYOUT_split_3x5_2(KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_Z, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_V, KC_B, KC_J, KC_X, KC_TRNS, KC_TRNS, KC_TRNS, KC_R, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_Q, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS),

  [_SYMBOLS] = LAYOUT_split_3x5_2(
    KC_AMPR,
    LABRC,
    RABRC,
    KC_BSLS,
    KC_TRNS,

    KC_TRNS,
    KC_DLR,
    KC_PEQL,
    KC_PPLS,
    KC_TRNS,

// ------------------------------------------------
    KC_UNDS,
    KC_SCLN,
    KC_COLN,
    KC_SLSH,
    KC_TRNS,

    KC_TRNS,
    KC_LBRC,
    KC_LPRN,
    KC_LCBR,
    KC_DQUO,
// ------------------------------------------------

    OSL(_ARROWS_NUMPAD),
    KC_TRNS,
    KC_TRNS,
    KC_TRNS,
    KC_TRNS,

    KC_S,
    KC_RBRC,
    KC_RPRN,
    KC_RCBR,
    OSL(_FLOW_SYMBOLS),

    // 👍🏻
    KC_TRNS,
    KC_TRNS,
    KC_TRNS,
    KC_TRNS
  ),


  [_FLOW_SYMBOLS] = LAYOUT_split_3x5_2(KC_TRNS, KC_TRNS, KC_PERC, KC_DLR, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_QUOT, KC_PMNS, KC_PAST, KC_TRNS, KC_TRNS, KC_TRNS, KC_HASH, KC_PIPE, KC_GRV, KC_PERC, KC_TRNS, KC_EXLM, KC_TRNS, KC_QUES, KC_TRNS, KC_TRNS, KC_CIRC, KC_TILDE, KC_AT, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS),

// ************************************************
  // ✅ Arrows, Numpad, Math Symbols, Window Movement
  [_ARROWS_NUMPAD] = LAYOUT_split_3x5_2(
    KC_SPC,
    KC_7,
    KC_8,
    KC_9,
    KC_TRNS,

    KC_TRNS,
    KC_DLR,
    KC_PEQL,
    KC_PPLS,
    KC_TRNS,

// ------------------------------------------------
    KC_LEFT,
    KC_DOWN,
    KC_UP,
    KC_RIGHT,
    KC_TRNS,

    KC_TRNS,
    KC_1,
    SUPER2,
    CTL3,
    SFT0,
// ------------------------------------------------

    KC_SPC,
    KC_TRNS,
    KC_TRNS,
    KC_TRNS,
    KC_TRNS,

    KC_TRNS,
    KC_4,
    KC_5,
    KC_6,
    S(KC_G),

    // 👍🏻
    OSM(MOD_LSFT),
    KC_TRNS,
    MOVE_LEFT_WORD,
    MOVE_RIGHT_WORD
  ),

  // 👷🏻 WIP: Lots of empty spaces. Can put common synergies here
  // S added to corner for search and replace :s/ synergy
// ************************************************


  // ✅ Mouse on left, right has equal sign and encloser symbols
// ************************************************
  [_MOUSE_7SYMBOLS] = LAYOUT_split_3x5_2(
    KC_WH_L,
    KC_WH_D,
    KC_WH_U,
    KC_WH_R,
    KC_BTN2,

    KC_TRNS,
    OSM(MOD_RGUI),
    OSM(MOD_RALT),
    OSM(MOD_RCTL),
    OSM(MOD_RSFT),

// ------------------------------------------------
    KC_MS_LEFT,
    KC_MS_DOWN,
    KC_MS_UP,
    KC_MS_RIGHT,
    KC_TRNS,

    KC_TRNS,
    KC_HASH,
    KC_PIPE,
    KC_GRV,
    KC_PERC,
// ------------------------------------------------

    KC_DLR,
    KC_EXLM,
    KC_TRNS,
    KC_QUES,
    KC_TRNS,

    KC_TRNS,
    KC_CIRC,
    KC_TILDE,
    KC_AT,
    KC_TRNS,

    // 👍🏻
    MT(MOD_LCTL, KC_BTN2),
    KC_BTN1,
    KC_TRNS,
    KC_TRNS
  ),

  // ✅ app specific (tab/buffer) navigation: tmux/browser tabs, nvim open_buffers
  // system controls: zoom, sound, qk reboot
  // fullscreen
  // app launcher
// ************************************************
  [_QUICK_FIRE] = LAYOUT_split_3x5_2(
    KC_VOLD,
    KC_VOLU,
    KC_TRNS,
    SYS_FULLSCREEN,
    KC_MUTE,

    TM_RN_WIN,
    TM1,
    TM2,
    TM3,
    TM_PREV_SESS,

    STAB_TOGGLE,
    GO_BACK,
    GO_FORWARD,
    TAB_TOGGLE,
    KC_TRNS,

    KC_TRNS,
    A(KC_1),
    A(KC_2),
    A(KC_3),
    EMOJIS,

    KC_TRNS,
    SYS_FULLSCREEN,
    SYS_TOGGLE,
    APPLICATION_LAUNCHER,
    QK_BOOT,

    TM_PANE_CLOSE,
    A(KC_4),
    A(KC_5),
    A(KC_6),
    TM_WIN_NEW,

    KC_BTN1,
    KC_BTN1,
    KC_WH_D,
    KC_WH_U
  ),

 // 🏗️ fn keys and remaining
 // ************************************************
  [_FN] = LAYOUT_split_3x5_2(KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_F11, KC_F7, KC_F8, KC_F9, KC_F12, NV_RESET_LINE, NV_PREV_HUNK, NV_NEXT_HUNK, NV_STAGE_HUNK, KC_TRNS, KC_TRNS, KC_F1, KC_F2, KC_F3, KC_F10, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_F4, KC_F5, KC_F6, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS),
};


