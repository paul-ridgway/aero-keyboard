#!/usr/bin/env ruby

require 'hidapi'
require 'io/console'
require_relative 'keyboard'

bus_number = 1
device_address = 4
interface = 3

def checksum(data)
	255 - data.sum
end

def wrap(data)
	(data + [checksum(data)]).pack('c*')
end
brightness = 0x64

#                             prog  speed brightness   col   ???
SOLID_GRN      = [0x08, 0x00, 0x01, 0x06, brightness, 0x07, 0x01]
PRESS_FADE_GRN = [0x08, 0x00, 0x04, 0x0a, brightness, 0x02, 0x01] 
PRESS_FADE_YEL = [0x08, 0x00, 0x04, 0x0a, brightness, 0x03, 0x01]
PRESS_FADE_RND = [0x08, 0x00, 0x04, 0x0a, brightness, 0x08, 0x01]
MARQUEE        = [0x08, 0x00, 0x0c, 0x0a, brightness, 0x0a, 0x01]
CUSTOM_1       = [0x08, 0x00, 0x37, 0x06, brightness, 0x01, 0x01]

# 							  custom index (zero based)
START_PROG     = [0x12, 0x00, 0x04, 0x08, 0x00, 0x00, 0x00, 0xe1]
begin
	puts "Opening device..."
	dev = HIDAPI::open_path("#{bus_number.to_s(16)}:#{device_address.to_s(16)}:#{interface.to_s(16)}")

	# puts "Set Yellow..."
	# dev.send_feature_report wrap(PRESS_FADE_YEL)

	# sleep 2

	# puts "Set Solid Green..."
	# dev.send_feature_report wrap(SOLID_GRN)

	# sleep 2

	# puts "Set Green..."
	# dev.send_feature_report wrap(PRESS_FADE_GRN)
	# # dev.send_feature_report wrap(MARQUEE)

	

	# 128.times do |t|
  t = Keyboard::Keys::ENTER
		# Select Custom 1
		puts "CUSTOM_1"
		dev.send_feature_report wrap(CUSTOM_1)

		# sleep 0.2
		puts "START_PROG"
		dev.send_feature_report wrap(START_PROG)

		8.times do |i|
			start = i * 16
			data = []
			16.times do |j|
				idx = start + j + 1
				r = 0
				g = 0
				b = 0
				if idx == t
					r = 255
					g = 255
					b = 255
				elsif idx < t
					b = 255
					g = 255
				end
				data += [idx, r, g, b]
			end		

			# pp data

			puts "Write #{i}, len: #{data.size}, start: #{start}"
			dev.write(data.pack('c*'))
		end
		# sleep 0.1

		# puts "Reading..."
		# read = dev.read
		# puts "Read: #{read}"

		# Select Custom 1
		puts "CUSTOM_1"
		dev.send_feature_report wrap(CUSTOM_1)
		# puts "This is #{t}, press to continue..."
		# STDIN.getch 
	# end

rescue Exception => e
	puts "Error: #{e.message}"
	puts e.backtrace
ensure
	puts "Closing device"
	dev.close	
end