#!/usr/bin/env ruby

require 'hidapi'
require 'io/console'
require_relative 'keyboard'

keyboard = Keyboard.open
begin
  layout = {
      Keyboard::GROUPS.all => [32, 128, 255],
      # Keyboard::GROUPS.all => [64, 255, 127],
  }
  keyboard.custom_map(0, 100, layout)
rescue Exception => e
  puts "Error: #{e.message}"
  puts e.backtrace
ensure
  puts "Closing device"
  keyboard.close
end