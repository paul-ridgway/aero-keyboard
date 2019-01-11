#!/usr/bin/env ruby

require 'hidapi'
require 'io/console'
require_relative 'keyboard'

keyboard = Keyboard.open
begin
  puts keyboard.current_configuration_pretty

  keyboard.set_configuration(Keyboard::ANIMATIONS.rotate, 0, 100, Keyboard::COLOURS.purple)

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