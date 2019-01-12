#!/usr/bin/env ruby

require 'hidapi'
require 'io/console'
require_relative 'keyboard'

keyboard = Keyboard.open
begin
  layout = Hash[Keyboard::KEYS.map {|k| [k, [Random.rand(256), Random.rand(256), Random.rand(256)]]}]
  keyboard.custom_map(1, 100, layout)
rescue Exception => e
  puts "Error: #{e.message}"
  puts e.backtrace
ensure
  puts "Closing device"
  keyboard.close
end
