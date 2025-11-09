#include QMK_KEYBOARD_H
#if __has_include("keymap.h")
#    include "keymap.h"
#endif

// for key codes consult with this
// https://docs.qmk.fm/keycodes
const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
    // no modifiers
    [0] = LAYOUT_split_3x6_3_ex2(
        KC_TAB,  KC_Q, KC_W, KC_E, KC_R,    KC_T,  KC_NO,  /**/ LCTL(KC_6), KC_Y,  KC_U, KC_I,    KC_O,   KC_P,    KC_BSPC,
        KC_ESC,  KC_A, KC_S, KC_D, KC_F,    KC_G,  KC_NO,  /**/ LSFT(KC_8), KC_H,  KC_J, KC_K,    KC_L,   KC_SCLN, KC_QUOT,
        KC_LSFT, KC_Z, KC_X, KC_C, KC_V,    KC_B,          /**/             KC_N,  KC_M, KC_COMM, KC_DOT, KC_SLSH, KC_RSFT,
                                   KC_LGUI, MO(1), KC_SPC, /**/ KC_ENT,     MO(2), KC_LCTL
    ),
    // left thumb MO
    [1] = LAYOUT_split_3x6_3_ex2(
        KC_GRV,  KC_1,  KC_2,  KC_3,  KC_4,    KC_5,    LAG(KC_W), /**/ KC_NO,  KC_6,    KC_7,    KC_8,    KC_9,    KC_0,    KC_BSPC,
        KC_NO,   KC_NO, KC_NO, KC_NO, KC_NO,   KC_NO,   LAG(KC_E), /**/ KC_NO,  KC_MINS, KC_EQL,  KC_LBRC, KC_RBRC, KC_BSLS, KC_NO,
        KC_LSFT, KC_NO, KC_NO, KC_NO, KC_NO,   KC_NO,              /**/         KC_NO,   KC_NO,   KC_COMM, KC_DOT,  KC_NO,   KC_RSFT,
                                      KC_LGUI, KC_TRNS, KC_SPC,    /**/ KC_ENT, MO(3),   KC_LCTL
    ),
    // right thumb MO
    [2] = LAYOUT_split_3x6_3_ex2(
        KC_GRV,  KC_1,  KC_2,  KC_3,   KC_4,    KC_5,  KC_NO,  /**/ LAG(KC_I), KC_6,    KC_7,    KC_8,  KC_9,    KC_0,  KC_BSPC,
        KC_NO,   KC_NO, KC_NO, KC_NO,  KC_NO,   KC_NO, KC_NO,  /**/ KC_NO,     KC_LEFT, KC_DOWN, KC_UP, KC_RGHT, KC_NO, KC_NO,
        KC_LSFT, KC_NO, KC_NO, KC_NO,  KC_NO,   KC_NO,         /**/            KC_NO,   KC_NO,   KC_NO, KC_NO,   KC_NO, KC_RSFT,
                                       KC_LGUI, MO(3), KC_SPC, /**/ KC_ENT,    KC_TRNS, KC_LOPT
    ),
    // both thumbs MO
    [3] = LAYOUT_split_3x6_3_ex2(
        QK_BOOT, KC_NO, KC_NO, KC_NO, KC_NO,   KC_NO,   KC_BRIU, /**/ KC_VOLU, KC_NO,   KC_NO, KC_NO, KC_NO, KC_NO, QK_RBT,
        RM_TOGG, KC_NO, KC_NO, KC_NO, KC_NO,   KC_NO,   KC_BRID, /**/ KC_VOLD, KC_NO,   KC_NO, KC_NO, KC_NO, KC_NO, KC_NO,
        RM_NEXT, KC_NO, KC_NO, KC_NO, KC_NO,   KC_NO,            /**/          KC_NO,   KC_NO, KC_NO, KC_NO, KC_NO, KC_NO,
                                      KC_LGUI, KC_TRNS, KC_SPC,  /**/ KC_ENT,  KC_TRNS, KC_NO
    )
};



#ifdef OTHER_KEYMAP_C
#    include OTHER_KEYMAP_C
#endif // OTHER_KEYMAP_C

