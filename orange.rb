#!/usr/bin/env ruby

require 'hidapi'
require 'io/console'
require_relative 'keyboard'

keyboard = Keyboard.open
begin
  layout = {
      Keyboard::GROUPS.all => [255, 64, 10],
  }
  keyboard.custom_map(0, 100, layout)
rescue Exception => e
  puts "Error: #{e.message}"
  puts e.backtrace
ensure
  puts "Closing device"
  keyboard.close
end