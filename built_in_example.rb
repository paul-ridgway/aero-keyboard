#!/usr/bin/env ruby

require 'hidapi'
require 'io/console'
require_relative 'keyboard'

keyboard = Keyboard.open
begin
  keyboard.set_configuration(Keyboard::ANIMATIONS.hedge, 0, 100, Keyboard::COLOURS.random)
rescue Exception => e
  puts "Error: #{e.message}"
  puts e.backtrace
ensure
  puts "Closing device"
  keyboard.close
end