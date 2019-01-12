#!/usr/bin/env ruby

require 'hidapi'
require 'io/console'
require_relative 'keyboard'

keyboard = Keyboard.open
begin
  # TODO: Fix weird read issue:
  #
  # -> % ./kb_util.rb
  # Opening device 1:4:3...
  # Error: ANIMATIONS(:static => 1, :breathing => 2, :wave => 3, :fade_on_keypress => 4, :marquee => 5, :ripple => 6, :flash_on_keypress => 7, :neon => 8, :rainbow_marquee => 9, :raindrop => 10, :circle_marquee => 11, :hedge => 12, :rotate => 13, :custom_1 => 51, :custom_2 => 52, :custom_3 => 53, :custom_4 => 54, :custom_5 => 55) does not know 20
  # /home/paul/.rvm/gems/ruby-2.6.0/gems/yinum-2.2.2/lib/enum.rb:35:in `[]'
  # /home/paul/Documents/Code/aero-keyboard/keyboard/device.rb:15:in `current_configuration'
  # /home/paul/Documents/Code/aero-keyboard/keyboard/device.rb:23:in `current_configuration_pretty'
  # ./kb_util.rb:9:in `<main>'
  # Closing device
  #
  # puts keyboard.current_configuration_pretty

  # keyboard.set_configuration(Keyboard::ANIMATIONS.custom_2, 0, 100, Keyboard::COLOURS.purple)

  layout = {
      Keyboard::KEYS.a => [0, 255, 0],
      Keyboard::KEYS.b => [255, 0, 0]
  }


  layout = Hash[Keyboard::KEYS.map {|k| [k, [Random.rand(256), Random.rand(256), Random.rand(256)]]}]

  layout = {
      Keyboard::GROUPS.all => [64, 255, 127],
      Keyboard::GROUPS.fn_keys => [127, 64, 255],
      Keyboard::GROUPS.numbers_row => [127, 255, 255],
      Keyboard::GROUPS.numbers => [255, 127, 127],
      Keyboard::GROUPS.numpad => [127, 255, 127],
      Keyboard::GROUPS.arrows => [255, 127, 255],
      Keyboard::GROUPS.non_fn_keys => [127, 255, 255],
      Keyboard::GROUPS.navigation => [255, 255, 127],
      Keyboard::GROUPS.letters => [255, 255, 127],
      Keyboard::GROUPS.non_letters => [127, 127, 255],
      Keyboard::KEYS.enter => [255, 255, 255],
      Keyboard::KEYS.space => [100, 100, 255],
  }

  # layout = {43 => [255, 0, 255]}

  keyboard.custom_map(0, 100, layout)

rescue Exception => e
  puts "Error: #{e.message}"
  puts e.backtrace
ensure
  puts "Closing device"
  keyboard.close
end