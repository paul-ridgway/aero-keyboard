require 'yinum'

module Keyboard


  ANIMATIONS = Enum.new(:ANIMATIONS,
                        static: 0x01,
                        breathing: 0x02,
                        wave: 0x03,
                        fade_on_keypress: 0x04,
                        marquee: 0x05,
                        ripple: 0x06,
                        flash_on_keypress: 0x07,
                        neon: 0x08,
                        rainbow_marquee: 0x09,
                        raindrop: 0x0a,
                        circle_marquee: 0x0b,
                        hedge: 0x0c,
                        rotate: 0x0d,
                        custom_1: 0x33,
                        custom_2: 0x34,
                        custom_3: 0x35,
                        custom_4: 0x36,
                        custom_5: 0x37)

end
