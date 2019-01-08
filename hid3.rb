#!/usr/bin/env ruby

require 'hidapi'
require 'io/console'
require_relative 'keyboard'
# def checksum(data)
#   255 - data.sum
# end
#
# def checksum_packet(data)
#   (data + [checksum(data)])
# end
#
# def wrap(data)
#   checksum_packet(data).pack('c*')
# end
#
# def print_hex(data)
#   data = data.bytes if data.is_a? String
#   data.map {|b| sprintf(", 0x%02X", b)}.join
# end
#
# brightness = 0x64
# speed = 0x0a
#
# #                       x x      prog  speed brightness   col   ???
# SOLID_GRN = [0x08, 0x00, Keyboard::Animations::STATIC, speed, brightness, Keyboard::Colours::GREEN, 0x01]
# PRESS_FADE_GRN = [0x08, 0x00, Keyboard::Animations::FADE_ON_KEYPRESS, 0x0a, brightness, Keyboard::Colours::GREEN, 0x01]
# PRESS_FADE_YEL = [0x08, 0x00, Keyboard::Animations::FADE_ON_KEYPRESS, speed, brightness, Keyboard::Colours::YELLOW, 0x01]
# PRESS_FADE_RND = [0x08, 0x00, Keyboard::Animations::FADE_ON_KEYPRESS, speed, brightness, Keyboard::Colours::RANDOM, 0x01]
# MARQUEE = [0x08, 0x00, Keyboard::Animations::MARQUEE, speed, brightness, Keyboard::Colours::PURPLE, 0x01]
# CUSTOM_1 = [0x08, 0x00, Keyboard::Animations::CUSTOM_1, speed, brightness, 0x00, 0x01]
#
# # 							  custom index (zero based)
# START_PROG = [0x12, 0x00, 0x04, 0x08, 0x00, 0x00, 0x00, 0xe1]

keyboard = Keyboard.open
begin
  puts keyboard.current_configuration_pretty

rescue Exception => e
  puts "Error: #{e.message}"
  puts e.backtrace
ensure
  puts "Closing device"
  keyboard.close
end


# begin
#
#   puts "Set Yellow..."
#   dev.send_feature_report wrap(PRESS_FADE_YEL)
#   #
#   sleep 2
#   #
#   puts "Set Solid Green..."
#   dev.send_feature_report wrap(SOLID_GRN)
#   #
#   sleep 2
#   #
#   puts "Set Green..."
#   # dev.send_feature_report wrap(PRESS_FADE_GRN)
#   dev.send_feature_report wrap(PRESS_FADE_RND)
#
#   pp print_hex(dev.get_feature_report(1))
#
#   pp print_hex(checksum_packet(SOLID_GRN))
#   pp print_hex(checksum_packet(PRESS_FADE_GRN))
#   pp print_hex(checksum_packet(PRESS_FADE_YEL))
#   pp print_hex(checksum_packet(PRESS_FADE_RND))
#   pp print_hex(checksum_packet(MARQUEE))
#   pp print_hex(checksum_packet(CUSTOM_1))
#
#   exit 0
#
#   # 128.times do |t|
#   t = Keyboard::Keys::NUM_END
#   # Select Custom 1
#   puts "CUSTOM_1"
#   dev.send_feature_report wrap(CUSTOM_1)
#
#   # sleep 0.2
#   puts "START_PROG"
#   dev.send_feature_report wrap(START_PROG)
#
#   8.times do |i|
#     start = i * 16
#     data = []
#     16.times do |j|
#       idx = start + j + 1
#       r = 0
#       g = 0
#       b = 0
#       if idx == t
#         r = 255
#         g = 255
#         b = 255
#       elsif idx < t
#         b = 255
#         g = 255
#       end
#       data += [idx, r, g, b]
#     end
#
#     # pp data
#
#     puts "Write #{i}, len: #{data.size}, start: #{start}"
#     dev.write(data.pack('c*'))
#   end
#   # sleep 0.1
#
#   # puts "Reading..."
#   # read = dev.read
#   # puts "Read: #{read}"
#
#   # Select Custom 1
#   puts "CUSTOM_1"
#   dev.send_feature_report wrap(CUSTOM_1)
#     # puts "This is #{t}, press to continue..."
#     # STDIN.getch
#     # end
#
# rescue Exception => e
#   puts "Error: #{e.message}"
#   puts e.backtrace
# ensure
#   puts "Closing device"
#   dev.close
# end