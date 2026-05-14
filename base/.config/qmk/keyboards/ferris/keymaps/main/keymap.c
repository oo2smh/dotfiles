#include QMK_KEYBOARD_H
/////////////////////////////////////////////////
// OVERVIEW
/////////////////////////////////////////////////
enum layers {
  _T_BASE,
  _T_SCRAPS,
  _SYMBOLS,
  _ARROWS_NUMPAD,
  _MOUSE_7SYMBOLS,
  _QUICK_FIRE,
  _FN,
};

enum custom_keycodes {
  OS_TOGGLE = SAFE_RANGE,
  SYS_TOGGLE,
  TOP_LVL_TOGGLE,
  TERM_TOGGLE,
  SCREENSHOT,
  LAUNCHPAD,
  CLOSE_INSTANCE,
  CLOSE_WINDOW  ,
  ZOOM_IN,
  ZOOM_OUT,
  MOVE_LEFT_WORD,
  MOVE_RIGHT_WORD,
  GO_BACK,
  GO_FORWARD,
  L_WKSPC,
  R_WKSPC,
  EMOJIS,
  COPY,
  PASTE,
  UNDO,
  REDO,
  SLEEP,
  SHUTDOWN,

  // CTL SERIES
  CTL_ENT,
  CTL_S,
  CTL_C,
  CTL_N,
  CTL_A,
  CTL_G,
  CTL_L,
  CTL_T,
  CTL_P,

  // TMUX (6)
  TM_PANE_CLOSE,
  TM_WIN_NEW,
  TM_RN_WIN,
  TM_PREV_SESS,
  TM1,
  TM2,

  XOURNAL_WHITE,
  XOURNAL_SELECT,
  XOURNAL_ERASE,
  XOURNAL_HIGHLIGHTER,
  XOURNAL_HAND,

  XOURNAL_GRAY,
  XOURNAL_NEON,
  XOURNAL_ORANGE,
  XOURNAL_RED,
  XOURNAL_CYAN,
  FIG_MARKER,
  FIG_MOVE,
  FIG_ERASE,
  FIG_HIGHLIGHT,

  // NVIM
  NV_FILEPATH,
  NV_ZZ,
  NV_gt,
  NV_gT,
  NV_FOLD_MAKE,
  NV_FOLD_TOGGLE,
  NV_FOLD_TOGGLE_DEPTH,
  NV_FOLD_DELETE,
  NV_FOLD_ALL,
  NV_UNFOLD_ALL,
  NV_GX,
  NV_INSERT_PASTE,
  NV_MAKE_GMARK,
  NV_GOTO_GMARK,

  // COMMON SYNERGIES
  VISUAL_LINE,
  RK,
  DICTATION,
  DEVTOOL_SELECT,

  // SYSTEM
  REF_LAYER,
  MOUSE_REF_VIEW,
  TEXT_REF_VIEW,
  PASTE_AND_POP, // uses a custom shell script
  DEL_WORD,
};

/////////////////////////////////////////////////
// VARIABLES
/////////////////////////////////////////////////
// ZONE: 🐧 OS_SPECIFIC
static bool is_mac = false;

void tap_os_key(uint16_t mac_kc, uint16_t win_kc) {
    tap_code16(is_mac ? mac_kc : win_kc);
}

typedef struct {
    uint16_t keycode;
    uint16_t win_key;
    uint16_t mac_key;
} os_key_map_t;

const os_key_map_t os_keys[] = {
    {SYS_TOGGLE,      A(KC_TAB),   G(KC_TAB)},
    {SCREENSHOT,      LSG(KC_S),   G(S(KC_3))}, // Standardized Mac Screenshot
    {LAUNCHPAD,       G(KC_S),     KC_LAUNCHPAD}, // Reliable Mac Launchpad
    {CLOSE_INSTANCE,  C(KC_W),     G(KC_W)},
    {CLOSE_WINDOW,    A(KC_F4),    G(KC_Q)},
    {ZOOM_IN,         C(KC_PPLS),  G(KC_PPLS)},
    {ZOOM_OUT,        C(KC_PMNS),  G(KC_PMNS)},
    {EMOJIS,          G(KC_SCLN),  G(C(KC_SPC))},
    {MOVE_LEFT_WORD,  C(KC_LEFT),  A(KC_LEFT)},
    {MOVE_RIGHT_WORD, C(KC_RIGHT), A(KC_RIGHT)},
    {GO_BACK, A(KC_LEFT), G(KC_LBRC)},
    {GO_FORWARD, A(KC_RIGHT), G(KC_RBRC)},
    {TOP_LVL_TOGGLE, G(KC_TAB), C(KC_UP)},
    {L_WKSPC, RCG(KC_LEFT), C(KC_LEFT)},
    {R_WKSPC, RCG(KC_RIGHT), C(KC_RIGHT)},
    {SLEEP, KC_SLEP, LCG(KC_Q)},
    {SHUTDOWN, KC_PWR, LSG(KC_SPC)},
    {DEL_WORD, C(KC_BSPC), A(KC_BSPC)},
    {CTL_ENT, C(KC_ENT), G(KC_ENT)},
    {DEVTOOL_SELECT, RCS(KC_E), RSG(KC_E)},
    {XOURNAL_WHITE, RCS(KC_D), RSG(KC_D)},
    {XOURNAL_ERASE, RCS(KC_E), RSG(KC_E)},
    {XOURNAL_SELECT, RCS(KC_R), RSG(KC_R)},
    {XOURNAL_HAND, RCS(KC_A), RSG(KC_A)},
    {XOURNAL_HIGHLIGHTER, RCS(KC_H), RSG(KC_H)},

    {CTL_S, C(KC_S), C(KC_S)},
    {CTL_N, C(KC_N), C(KC_N)},
    {CTL_C, C(KC_C), G(KC_C)},
    {CTL_A, C(KC_A), G(KC_A)},
    {CTL_G, C(KC_G), G(KC_G)},
    {CTL_L, C(KC_L), G(KC_L)},
    {CTL_T, C(KC_T), G(KC_T)},
    {CTL_P, C(KC_P), G(KC_P)},
    {COPY, C(KC_C), G(KC_C)},
    {PASTE, C(KC_V), G(KC_V)},
    {UNDO, C(KC_Z), G(KC_Z)},
    {REDO, C(KC_R), G(S(KC_Z))},
};

bool handle_os_aware_keys(uint16_t keycode, bool pressed) {
    for (uint8_t i = 0; i < sizeof(os_keys) / sizeof(os_key_map_t); i++) {
        if (keycode == os_keys[i].keycode) {
            if (pressed) {
                tap_os_key(os_keys[i].win_key, os_keys[i].mac_key);
            }
            return true;
        }
    }
    return false;
}

// THUMB
#define TH_TAB LT(_FN, KC_TAB)
#define TH_SCRAPS OSL(_T_SCRAPS)
#define TH_SPC LT(_ARROWS_NUMPAD, KC_SPC)
#define TH_R LT(_MOUSE_7SYMBOLS, KC_R)

// LEFT BOT & RIGHT
#define LB_DOT MT(MOD_LCTL, KC_DOT)
#define LB_BSPC MT(MOD_LALT, KC_BSPC)
#define LB_COMM MT(MOD_LGUI, KC_COMM)
#define LB_SFT OSM(MOD_LSFT)
#define RB_SFT OSM(MOD_RSFT)

// LAYER SPECIFIC KEYS
#define CTL0 MT(MOD_RCTL, KC_0)
#define SFT_F MT(MOD_RSFT, KC_F)
#define MOUSE_REF_VIEW A(KC_R)

// OS-SAME
#define TERM_TOGGLE G(KC_SPC)
#define TMUX_FULLSCREEN A(KC_SPC)
#define TMUX_TOGGLE A(KC_C)
#define TAB_TOGGLE C(KC_TAB)
#define SFT_TAB RCS(KC_TAB)

// MUST SETUP WITHIN OS
#define SYS_FULLSCREEN KC_F11
#define SCREENSHOT_OCR LSG(KC_O)
#define CLIPBOARD LCG(KC_V)

// MISC
#define LABRC S(KC_COMM)
#define RABRC S(KC_DOT)


/////////////////////////////////////////////////
// CONFIG
/////////////////////////////////////////////////
// NOTE: For faster access to non-texts (nums and symbols), I reduced the tap-term drastically for R and SPC. Don't linger when you press R and SPC unless you want to access (nums and symbols)!

uint16_t get_tapping_term(uint16_t keycode, keyrecord_t *record) {
  switch (keycode) {
    case TH_R:
    case TH_SPC:
      return 150;
    case OSL(_SYMBOLS):
      return 0;
    case CTL0:
      return 200;
    default:
      return TAPPING_TERM; // Uses the default for all other keys
  }
}

/////////////////////////////////////////////////
// COMBOS
/////////////////////////////////////////////////
// NAV
const uint16_t PROGMEM l_wkspc[] = {TH_R, TH_SPC, TH_TAB, COMBO_END};
const uint16_t PROGMEM r_wkspc[] = {TH_R, TH_SPC, TH_SCRAPS, COMBO_END};
const uint16_t PROGMEM mon_toggle[] = {KC_A, KC_I, KC_E, COMBO_END};
const uint16_t PROGMEM sys_toggle[] = {KC_A, KC_U, COMBO_END};
const uint16_t PROGMEM term_toggle[] = {KC_H, KC_L, COMBO_END};
const uint16_t PROGMEM tmux_toggle[] = {KC_H, KC_N, COMBO_END};
const uint16_t PROGMEM sys_fullscreen[] = {KC_I, KC_E, TH_SPC, COMBO_END};
const uint16_t PROGMEM tmux_fullscreen[] = {KC_A, KC_E, TH_SPC, COMBO_END};

const uint16_t PROGMEM ref_view[] = {OSM(MOD_LCTL), KC_Y, COMBO_END};
const uint16_t PROGMEM base_layer[] = {TH_SPC, TH_R, TH_TAB, TH_SCRAPS, COMBO_END};
const uint16_t PROGMEM symbol_layer[] = {TH_R, TH_SCRAPS, COMBO_END};
const uint16_t PROGMEM quick_fire_layer[] = {TH_TAB, TH_SPC, COMBO_END};
const uint16_t PROGMEM symbol_layer1[] = {QK_REP, KC_H, COMBO_END};
const uint16_t PROGMEM num_layer[] = {KC_I, LB_BSPC, COMBO_END};

// SYS FUNCTIONALITY
const uint16_t PROGMEM close_instance[] = {LB_BSPC, LB_DOT, COMBO_END};
const uint16_t PROGMEM close_frame[] = {LB_COMM, LB_DOT, COMBO_END};
const uint16_t PROGMEM shutdown[] = {LB_SFT, LB_DOT, LB_BSPC, LB_COMM, TH_SPC, COMBO_END};
const uint16_t PROGMEM sleep[] = {LB_SFT, LB_DOT, LB_BSPC, LB_COMM, TH_TAB, COMBO_END};

// -- clipboard
const uint16_t PROGMEM sys_clipboard[]    = {TH_TAB, LB_COMM, COMBO_END};
const uint16_t PROGMEM sys_copy[]    = {TH_TAB, KC_E, COMBO_END};
const uint16_t PROGMEM sys_paste[]  = {TH_TAB, KC_I, COMBO_END};
const uint16_t PROGMEM sys_paste_pop[]  = {TH_TAB, KC_C, COMBO_END};
const uint16_t PROGMEM sys_redo[]  = {LB_COMM, QK_AREP, COMBO_END};
const uint16_t PROGMEM sys_undo[]  = {LB_BSPC, LB_COMM, COMBO_END};
const uint16_t PROGMEM sys_screenshot[]  = {TH_SPC, TH_TAB, KC_E, COMBO_END};
const uint16_t PROGMEM sys_screenshot_ocr[]  = {TH_SPC, TH_TAB, LB_BSPC, COMBO_END};

// SHORTCUTS
// ctl
const uint16_t PROGMEM ctl_s[] = {KC_P, KC_N, KC_T, COMBO_END};
const uint16_t PROGMEM ctl_ent[] = {KC_H, KC_N, KC_T, COMBO_END};
const uint16_t PROGMEM ctl_c[] = {KC_C, OSM(MOD_LCTL), COMBO_END};
const uint16_t PROGMEM ctl_l[] = {TH_R, KC_H, COMBO_END};
const uint16_t PROGMEM ctl_t[] = {TH_R, KC_T, COMBO_END};
const uint16_t PROGMEM ctl_n[] = {TH_R, KC_N, COMBO_END};
const uint16_t PROGMEM ctl_n2[] = {KC_P, KC_N, COMBO_END};
const uint16_t PROGMEM ctl_a[] = {TH_TAB, LB_SFT, COMBO_END};
const uint16_t PROGMEM ctl_g[] = {TH_R, KC_G, COMBO_END};
const uint16_t PROGMEM ctl_p[] = {TH_R, KC_P, COMBO_END};
const uint16_t PROGMEM ctl_p2[] = {KC_H, KC_N, KC_P, COMBO_END};

// browser
const uint16_t PROGMEM devtool_select[] = {KC_T, KC_D, KC_N, COMBO_END};

// text edit: general
const uint16_t PROGMEM rk[] = {TH_R, KC_K, COMBO_END};
const uint16_t PROGMEM k_del[] = {TH_TAB, LB_BSPC, COMBO_END};
const uint16_t PROGMEM k_del2[] = {KC_A, LB_BSPC, COMBO_END};
const uint16_t PROGMEM select_line[] = {QK_REP, KC_H, KC_T, COMBO_END};

// text edit: nvim
const uint16_t PROGMEM nv_filepath[] = {KC_F, KC_S, TH_SCRAPS, COMBO_END};
const uint16_t PROGMEM nv_zz[] = {KC_K, KC_M, COMBO_END};
const uint16_t PROGMEM nv_gt[] = {KC_K, QK_REP, COMBO_END};
const uint16_t PROGMEM nv_gT[] = {KC_K, QK_REP, KC_T, COMBO_END};
const uint16_t PROGMEM nv_gx[] = {KC_G, KC_M, KC_W, COMBO_END};
const uint16_t PROGMEM nv_fold_all[] = {KC_H, KC_T, TH_R, COMBO_END};
const uint16_t PROGMEM nv_unfold_all[] = {KC_N, KC_T, TH_R, COMBO_END};
const uint16_t PROGMEM nv_fold_make[] = {KC_F, KC_P, COMBO_END};
const uint16_t PROGMEM nv_fold_toggle[] = {KC_H, KC_P, COMBO_END};
const uint16_t PROGMEM nv_fold_toggle_depth[] = {KC_H, KC_P, KC_F, COMBO_END};
const uint16_t PROGMEM nv_fold_delete[] = {KC_F, KC_P, TH_SCRAPS, COMBO_END};
const uint16_t PROGMEM visual_block[] = {TH_R, KC_T, TH_SCRAPS, COMBO_END};
const uint16_t PROGMEM nv_goto_gmark[] = {TH_SCRAPS, KC_G, COMBO_END};
const uint16_t PROGMEM nv_make_gmark[] = {TH_SCRAPS, KC_M, COMBO_END};
const uint16_t PROGMEM nv_insert_paste[] = {TH_SCRAPS, KC_P, COMBO_END};
const uint16_t PROGMEM del_word[] = {KC_T, KC_D, COMBO_END};
const uint16_t PROGMEM spc_eql_spc[] = {TH_SPC, KC_O, COMBO_END};

// xournal
const uint16_t PROGMEM xournal_highlighter[]  = {TH_TAB, KC_I, KC_A, COMBO_END};

// KEYS
// core
const uint16_t PROGMEM ctlsft_th[] = {TH_TAB, TH_SCRAPS, COMBO_END};

const uint16_t PROGMEM esc_r[] = {KC_H, KC_T, COMBO_END};
const uint16_t PROGMEM esc_l[] = {KC_E, KC_A, COMBO_END};
const uint16_t PROGMEM ent_r[] = {KC_T, KC_N, COMBO_END};
const uint16_t PROGMEM ent_l[] = {KC_I, KC_E, COMBO_END};
const uint16_t PROGMEM tab_r[] = {TH_SCRAPS, KC_T, KC_N, COMBO_END};
const uint16_t PROGMEM stab_r[] = {TH_SCRAPS, KC_T, KC_H, COMBO_END};
const uint16_t PROGMEM sft_ent[] = {KC_N, KC_T, KC_H, COMBO_END};

const uint16_t PROGMEM k_quot[] = {KC_A, QK_REP, COMBO_END};
const uint16_t PROGMEM k_home[] = {KC_G, KC_M, COMBO_END};
const uint16_t PROGMEM k_end[] = {KC_G, KC_W, COMBO_END};
const uint16_t PROGMEM k_scln[] = {TH_SPC, KC_I, COMBO_END};
const uint16_t PROGMEM k_at[] =  {TH_R, KC_W, COMBO_END};
const uint16_t PROGMEM k_unds[] = {TH_SPC, KC_C, COMBO_END};
const uint16_t PROGMEM k_slsh[] = {TH_SPC, KC_A, COMBO_END};
const uint16_t PROGMEM k_coln[] = {KC_E, TH_SPC, COMBO_END};
const uint16_t PROGMEM k_ques[] = {KC_PAST, QK_REP, COMBO_END};
const uint16_t PROGMEM k_exlm[] = {KC_MINS, QK_REP, COMBO_END};

  // autopair synergies (())
const uint16_t PROGMEM k_q[] = {TH_SCRAPS, KC_W, COMBO_END};
const uint16_t PROGMEM k_v[] = {TH_SCRAPS, KC_H, COMBO_END};
const uint16_t PROGMEM k_z[] = {TH_SCRAPS, KC_F, COMBO_END};
const uint16_t PROGMEM k_b[] = {TH_SCRAPS, KC_T, COMBO_END};
const uint16_t PROGMEM k_j[] = {TH_SCRAPS, KC_N, COMBO_END};
const uint16_t PROGMEM k_x[] = {TH_SCRAPS, KC_S, COMBO_END};

combo_t key_combos[85] = {
    // TOGGLE 7
    COMBO(term_toggle, TERM_TOGGLE),
    COMBO(mon_toggle, TOP_LVL_TOGGLE),
    COMBO(sys_toggle, SYS_TOGGLE),
    COMBO(tmux_toggle, TMUX_TOGGLE),
    COMBO(sys_fullscreen, SYS_FULLSCREEN),
    COMBO(tmux_fullscreen, TMUX_FULLSCREEN),

    // SYS 17
    COMBO(l_wkspc, L_WKSPC),
    COMBO(r_wkspc, R_WKSPC),
    COMBO(term_toggle, TERM_TOGGLE),
    COMBO(sys_clipboard, CLIPBOARD),
    COMBO(sys_copy, COPY),
    COMBO(sys_paste, PASTE),
    COMBO(sys_undo, UNDO),
    COMBO(sys_redo, REDO),
    COMBO(sys_paste_pop, PASTE_AND_POP),
    COMBO(sys_screenshot, SCREENSHOT),
    COMBO(sys_screenshot_ocr, SCREENSHOT_OCR),
    COMBO(close_instance, CLOSE_INSTANCE),
    COMBO(close_frame, CLOSE_WINDOW),
    COMBO(ref_view, MOUSE_REF_VIEW),
    COMBO(sleep, SLEEP),
    COMBO(shutdown, SHUTDOWN),

    // Layer 6
    COMBO(symbol_layer, OSL(_SYMBOLS)),
    COMBO(symbol_layer1, OSL(_SYMBOLS)),
    COMBO(base_layer, TO(_T_BASE)),
    COMBO(quick_fire_layer, OSL(_QUICK_FIRE)),
    COMBO(num_layer, OSL(_ARROWS_NUMPAD)),

    // COMBO KEYS 9
    COMBO(ctlsft_th, OSM(MOD_LCTL | MOD_LSFT)),
    COMBO(ctl_ent, CTL_ENT),
    COMBO(ctl_s, CTL_S),
    COMBO(ctl_c, CTL_C),
    COMBO(ctl_n, CTL_N),
    COMBO(ctl_n2, CTL_N),
    COMBO(ctl_a, CTL_A),
    COMBO(ctl_g, CTL_G),
    COMBO(ctl_l, CTL_L),
    COMBO(ctl_t, CTL_T),
    COMBO(ctl_p, CTL_P),
    COMBO(ctl_p2, CTL_P),
    COMBO(devtool_select, DEVTOOL_SELECT),

    // TEXT MANIPULATION 9
    COMBO(rk, RK),
    COMBO(del_word, DEL_WORD),
    COMBO(nv_filepath, NV_FILEPATH),
    COMBO(nv_gx, NV_GX),
    COMBO(nv_zz, NV_ZZ),
    COMBO(nv_gt, NV_gt),
    COMBO(nv_gT, NV_gT),
    COMBO(nv_unfold_all, NV_UNFOLD_ALL),
    COMBO(nv_fold_all, NV_FOLD_ALL),
    COMBO(nv_fold_make, NV_FOLD_MAKE),
    COMBO(nv_fold_toggle, NV_FOLD_TOGGLE),
    COMBO(nv_fold_toggle_depth, NV_FOLD_TOGGLE_DEPTH),
    COMBO(nv_fold_delete, NV_FOLD_DELETE),
    COMBO(nv_insert_paste, NV_INSERT_PASTE),
    COMBO(k_del, KC_DEL),
    COMBO(k_del2, KC_DEL),
    COMBO(select_line, VISUAL_LINE),
    COMBO(nv_make_gmark, NV_MAKE_GMARK),
    COMBO(nv_goto_gmark, NV_GOTO_GMARK),
    COMBO(visual_block, C(KC_Q)),

    // KEYS 21
    COMBO(sft_ent, S(KC_ENT)),
    COMBO(esc_l, KC_ESC),
    COMBO(esc_r, KC_ESC),
    COMBO(ent_r, KC_ENT),
    COMBO(ent_l, KC_ENT),
    COMBO(tab_r, KC_TAB),
    COMBO(stab_r, S(KC_TAB)),
    COMBO(k_quot, KC_QUOT),
    COMBO(k_home, KC_HOME),
    COMBO(k_end, KC_END),
    COMBO(k_scln, KC_SCLN),
    COMBO(k_at, KC_AT),
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

    // XOURNAL (8)
    COMBO(xournal_highlighter, XOURNAL_HIGHLIGHTER),
};
/////////////////////////////////////////////////
// MACROS
///////////////////////
// ALTREP SETUP
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
        case KC_M: return KC_P;
        case KC_D: return KC_W;
        case KC_Z: return KC_F;
        case KC_PMNS: return RABRC;
        case KC_MINS: return RABRC;
        case KC_PEQL: return RABRC;
        case KC_COLN: return KC_PEQL;
        case KC_SCLN: return KC_SPC;
        case KC_AMPR: return KC_SPC;
        case KC_SLSH: return KC_SPC;

        case KC_1: return KC_7;
        case KC_2: return KC_8;
        case KC_3: return KC_9;
        case KC_4: return KC_1;
        case KC_5: return KC_2;
        case KC_6: return KC_3;
        case KC_7: return KC_1;
        case KC_8: return KC_2;
        case KC_9: return KC_3;

        case LABRC: return RABRC;
        case KC_LCBR: return KC_RCBR;
        case KC_LPRN: return KC_RPRN;
        case KC_RBRC: return KC_SCLN;
        case KC_RCBR: return KC_SCLN;
        case KC_RPRN: return KC_SCLN;
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
    // Select the modifier based on the OS state
    uint16_t mod = is_mac ? KC_LGUI : KC_LCTL;

    register_code(mod);
    register_code(KC_LSFT);
    tap_code16(KC_D);
    unregister_code(mod);
    unregister_code(KC_LSFT);

    // Brief delay can help OS-level shortcut recognition
    wait_ms(10);
    tap_code16(keycode);
}

bool process_record_user(uint16_t keycode, keyrecord_t* record) {
  if (handle_os_aware_keys(keycode, record->event.pressed)) {
    return false;
  }

  switch(keycode) {
    // ZONE: 🌐 GLOBAL
    case OS_TOGGLE:
      if (record->event.pressed) {
        is_mac = !is_mac;
      }
      return false;

    case DICTATION:
      if (record->event.pressed) {
        add_oneshot_mods(MOD_BIT(KC_LGUI));
        tap_code(KC_K);
      }
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

    case RK:
      if (record->event.pressed) {
        tap_code(KC_R);
        tap_code(KC_K);
      }
      break;

    // ZONE: 📜 NVIM SPECIFIC
    case NV_MAKE_GMARK:
    if (record->event.pressed) {
        tap_code(KC_M);
        set_oneshot_mods(MOD_BIT(KC_LSFT));
      }
    return false;

    case NV_gT:
      if (record->event.pressed) {
        tap_code(KC_G);
        set_oneshot_mods(MOD_BIT(KC_LSFT));
        tap_code(KC_T);
      }
    return false;

    case NV_gt:
      if (record->event.pressed) {
        tap_code(KC_G);
        tap_code(KC_T);
      }
    return false;

    case NV_FILEPATH:
      if (record->event.pressed) {
        set_oneshot_mods(MOD_BIT(KC_LCTL));
        tap_code(KC_X);
        set_oneshot_mods(MOD_BIT(KC_LCTL));
        tap_code(KC_F);
      }
      return false;

    case NV_ZZ:
      if (record->event.pressed) {
        tap_code(KC_Z);
        tap_code(KC_Z);
      }
      return false;

    case NV_GX:
      if (record->event.pressed) {
        tap_code(KC_G);
        tap_code(KC_X);
      }
      return false;

    case NV_GOTO_GMARK:
      if (record->event.pressed) {
        tap_code(KC_GRV);
        set_oneshot_mods(MOD_BIT(KC_LSFT));
      }
      return false;

    case VISUAL_LINE:
      if (record->event.pressed) {
        tap_code(KC_HOME);
        wait_ms(10);
        tap_code16(S(KC_END));
      }
    break;

    case NV_FOLD_DELETE:
      if (record->event.pressed) {
        tap_code(KC_Z);
        tap_code(KC_D);
      }
      break;

    case NV_UNFOLD_ALL:
      if (record->event.pressed) {
        tap_code(KC_Z);
        add_oneshot_mods(MOD_BIT(KC_LSFT));
        tap_code(KC_R);
        tap_code(KC_Z);
        tap_code(KC_Z);
      }
      break;

    case NV_FOLD_ALL:
      if (record->event.pressed) {
        tap_code(KC_Z);
        add_oneshot_mods(MOD_BIT(KC_LSFT));
        tap_code(KC_M);
      }
      break;

    case NV_FOLD_TOGGLE:
      if (record->event.pressed) {
        tap_code(KC_Z);
        tap_code(KC_A);
      }
      break;

    case NV_FOLD_TOGGLE_DEPTH:
      if (record->event.pressed) {
        tap_code(KC_Z);
        add_oneshot_mods(MOD_BIT(KC_LSFT));
        tap_code(KC_A);
      }
      break;

    case NV_FOLD_MAKE:
      if (record->event.pressed) {
        tap_code(KC_Z);
        tap_code(KC_F);
      }
      break;

    case NV_INSERT_PASTE:
      if (record->event.pressed) {
        add_oneshot_mods(MOD_BIT(KC_LCTL));
        tap_code(KC_R);
        tap_code(KC_0);
        tap_code(KC_RIGHT);
      }
      break;

    // ZONE: 🖼️ XOURNAL
    case XOURNAL_GRAY:
      if (record->event.pressed) {
        pen_mode_color(KC_2);
      }
      return false;

    case XOURNAL_NEON:
      if (record->event.pressed) {
        pen_mode_color(KC_6);
      }
      return false;

    case XOURNAL_CYAN:
      if (record->event.pressed) {
        pen_mode_color(KC_5);
      }
      return false;

    case XOURNAL_ORANGE:
      if (record->event.pressed) {
        pen_mode_color(KC_9);
      }
      return false;

    case XOURNAL_RED:
      if (record->event.pressed) {
        pen_mode_color(KC_0);
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

      // ZONE: 🐅TMUX
    case TM1:
    case TM2:
      if (record->event.pressed) {
        tmux(keycode == TM1 ? KC_1 : KC_2);
      }
      return false;

    case TM_WIN_NEW:
      if (record->event.pressed) {
        tmux(KC_C);
        tmux(KC_PERC);
      }
      return false;

    case TM_PANE_CLOSE:
    if (record->event.pressed) {
        tmux_close(KC_X);
      }
      return false;

    case TM_RN_WIN:
    if (record->event.pressed) {
        tmux(KC_COMM);
      }
      return false;

    case TM_PREV_SESS:
    if (record->event.pressed) {
        tmux(KC_LPRN);
      }
      return false;

  }
  return true;
};

/////////////////////////////////////////////////
// ZONE: 🎹 KEYMAPS
/////////////////////////////////////////////////
// T/B=top,bot | L/R=left,right
const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
  [_T_BASE] = LAYOUT_split_3x5_2(OSM(MOD_LCTL), KC_Y, KC_O, KC_U, KC_MINS, KC_PAST, KC_L, KC_D, KC_P, KC_F, KC_C, KC_I, KC_E, KC_A, QK_REP, QK_REP, KC_H, KC_T, KC_N, KC_S, LB_SFT, LB_DOT, LB_BSPC, LB_COMM, QK_AREP, KC_K, KC_M, KC_G, KC_W, RB_SFT, TH_TAB, TH_SPC, TH_R, TH_SCRAPS),

  [_T_SCRAPS] = LAYOUT_split_3x5_2(KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_Z, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_V, KC_B, KC_J, KC_X, CW_TOGG, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_Q, KC_CAPS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS),

  [_SYMBOLS] = LAYOUT_split_3x5_2(KC_AMPR, KC_PPLS, KC_PEQL, KC_BSLS, KC_TRNS, KC_TRNS, KC_DLR, KC_LBRC, KC_RBRC, KC_TRNS, KC_UNDS, KC_SCLN, KC_COLN, KC_SLSH, KC_TRNS, KC_TRNS, LABRC, KC_LPRN, KC_LCBR, KC_DQUO, MO(_ARROWS_NUMPAD), KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, RABRC, KC_RPRN, KC_RCBR, MO(_MOUSE_7SYMBOLS), KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS),

  [_ARROWS_NUMPAD] = LAYOUT_split_3x5_2(S(KC_G), KC_PPLS, KC_PEQL, KC_SLSH, KC_TRNS, KC_TRNS, KC_7, KC_8, KC_9, SFT_F, KC_LEFT, KC_DOWN, KC_UP, KC_RIGHT, KC_TRNS, KC_TRNS, KC_1, KC_2, KC_3, CTL0, KC_SPC, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_4, KC_5, KC_6, KC_TRNS, OSM(MOD_LSFT), KC_TRNS, MOVE_LEFT_WORD, MOVE_RIGHT_WORD),

  [_MOUSE_7SYMBOLS] = LAYOUT_split_3x5_2(MS_WHLL, MS_WHLD, MS_WHLU, MS_WHLR, OSM(MOD_LCTL), KC_TRNS, OSM(MOD_RGUI), OSM(MOD_RALT), OSM(MOD_RCTL), SFT_F, MS_LEFT, MS_DOWN, MS_UP, MS_RGHT, KC_TRNS, KC_TRNS, KC_HASH, KC_PIPE, KC_GRV, KC_PERC, KC_SPC, KC_TRNS, KC_TRNS, KC_TRNS, MS_BTN2, KC_TRNS, KC_CIRC, KC_TILDE, KC_AT, KC_TRNS, KC_TRNS, MS_BTN1, KC_TRNS, KC_TRNS),

  [_QUICK_FIRE] = LAYOUT_split_3x5_2(KC_VOLD, ZOOM_OUT, ZOOM_IN, KC_VOLU, KC_MUTE, KC_MUTE, A(KC_7), A(KC_8), A(KC_9), TM_PREV_SESS, SFT_TAB, GO_BACK, GO_FORWARD, TAB_TOGGLE, KC_TRNS, KC_TRNS, A(KC_1), A(KC_2), A(KC_3), EMOJIS, TM_WIN_NEW, TM_PANE_CLOSE, TG(_MOUSE_7SYMBOLS), LAUNCHPAD, MS_BTN2, QK_BOOT, A(KC_4), A(KC_5), A(KC_6), KC_TRNS, MS_BTN1, MS_BTN2, MS_WHLD, MS_WHLU),

   // 🏗️ fn keys
  [_FN] = LAYOUT_split_3x5_2(FIG_MOVE, FIG_HIGHLIGHT, FIG_MARKER, FIG_ERASE, OS_TOGGLE, KC_F11, KC_F7, KC_F8, KC_F9, KC_F12, XOURNAL_GRAY, XOURNAL_NEON, XOURNAL_WHITE, XOURNAL_ORANGE, XOURNAL_RED, KC_TRNS, KC_F1, KC_F2, KC_F3, KC_F10, CTL_A, XOURNAL_SELECT, MT(MOD_LALT, KC_DEL), XOURNAL_ERASE, XOURNAL_HAND, KC_TRNS, KC_F4, KC_F5, KC_F6, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS),
};

