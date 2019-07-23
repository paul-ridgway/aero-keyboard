#!/usr/bin/env ruby

require 'hidapi'
require 'io/console'
require_relative 'keyboard'

keyboard = Keyboard.open
begin
  keyboard.set_configuration(Keyboard::ANIMATIONS.static, 0, 100, Keyboard::COLOURS.white)
rescue Exception => e
  puts "Error: #{e.message}"
  puts e.backtrace
ensure
  puts "Closing device"
  keyboard.close
end