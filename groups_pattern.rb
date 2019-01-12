#!/usr/bin/env ruby

require 'hidapi'
require 'io/console'
require_relative 'keyboard'

keyboard = Keyboard.open
begin
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
  keyboard.custom_map(0, 100, layout)
rescue Exception => e
  puts "Error: #{e.message}"
  puts e.backtrace
ensure
  puts "Closing device"
  keyboard.close
end