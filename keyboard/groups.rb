require 'yinum'
require_relative 'keys'

module Keyboard
  GROUPS = Enum.new(:GROUPS,
                    all: KEYS.to_a,
                    fn_keys: [KEYS.f1, KEYS.f2, KEYS.f3, KEYS.f4, KEYS.f5, KEYS.f6, KEYS.f7, KEYS.f8, KEYS.f9,
                              KEYS.f10, KEYS.f11, KEYS.f12],
                    numbers: [KEYS.d0, KEYS.d1, KEYS.d2, KEYS.d3, KEYS.d4, KEYS.d5, KEYS.d6, KEYS.d7, KEYS.d8, KEYS.d9],
                    numbers_row: [KEYS.tilde, KEYS.d0, KEYS.d1, KEYS.d2, KEYS.d3, KEYS.d4, KEYS.d5, KEYS.d6, KEYS.d7,
                                  KEYS.d8, KEYS.d9, KEYS.hyphen, KEYS.equals, KEYS.backspace],
                    numpad: [KEYS.num_1, KEYS.num_4, KEYS.num_7, KEYS.num_lock, KEYS.num_0, KEYS.num_2, KEYS.num_5,
                             KEYS.num_8, KEYS.num_slash, KEYS.num_del, KEYS.num_3, KEYS.num_6, KEYS.num_9,
                             KEYS.num_asterisk, KEYS.num_enter, KEYS.num_plus, KEYS.num_minus],
                    navigation: [KEYS.num_home, KEYS.num_end, KEYS.num_page_up, KEYS.num_page_down],
                    arrows: [KEYS.left, KEYS.up, KEYS.down, KEYS.right],
                    non_fn_keys: [KEYS.escape, KEYS.pause, KEYS.delete, KEYS.num_home, KEYS.num_end, KEYS.num_page_up,
                                  KEYS.num_page_down],
                    letters: [KEYS.a, KEYS.b, KEYS.c, KEYS.d, KEYS.e, KEYS.f, KEYS.g, KEYS.h, KEYS.i, KEYS.j, KEYS.k,
                              KEYS.l, KEYS.m, KEYS.n, KEYS.o, KEYS.p, KEYS.q, KEYS.r, KEYS.s, KEYS.t, KEYS.u, KEYS.v,
                              KEYS.w, KEYS.x, KEYS.y, KEYS.z],
                    non_letters: [KEYS.slash, KEYS.backslash, KEYS.semi, KEYS.full_stop, KEYS.sharp, KEYS.apostrophe,
                                  KEYS.left_square_bracket, KEYS.right_square_bracket, KEYS.comma]
  )
end
