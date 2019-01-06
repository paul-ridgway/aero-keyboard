#!/usr/bin/env ruby

require 'hidapi'

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

# Program:
#   0x01 = Static
#   0x02 = Breathing
#   0x03 = Wave
#   0x04 = Fade on Keypress
#   0x05 = Marquee (does not support random colour)
#   0x06 = Ripple 
#   0x07 = Flash on Keypress
#   0x08 = Neon
#   0x09 = Rainbow Marquee (only supports random colour)
#   0x0a = Raindrop
#   0x0b = Circle Marquee
#   0x0c = Hedge
#   0x0d = Rotate
#   0x33 = Custom 1
#   0x34 = Custom 2
#   0x35 = Custom 3
#   0x36 = Custom 4
#   0x37 = Custom 5

# Speed:
#   0x0a = min
#   0x01 = fase

# Colour:
#   0x01 = Red
#   0x02 = Green
#   0x03 = Yellow
#   0x04 = Blue
#   0x05 = Orange
#   0x06 = Purple
#   0x07 = White
#   0x08 = Rainbow / Random
#   All other values in 00 = random
#                             prog  speed brightness   col   ???
SOLID_GRN      = [0x08, 0x00, 0x01, 0x06, brightness, 0x02, 0x01]
PRESS_FADE_GRN = [0x08, 0x00, 0x04, 0x0a, brightness, 0x02, 0x01] 
PRESS_FADE_YEL = [0x08, 0x00, 0x04, 0x0a, brightness, 0x03, 0x01]
PRESS_FADE_RND = [0x08, 0x00, 0x04, 0x0a, brightness, 0x08, 0x01]
MARQUEE        = [0x08, 0x00, 0x0c, 0x0a, brightness, 0x0a, 0x01]
CUSTOM_1       = [0x08, 0x00, 0x33, 0x06, brightness, 0x01, 0x01]
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
	dev.send_feature_report wrap(MARQUEE)
rescue Exception => e
	puts "Error: #{e.message}"
	puts e.backtrace
ensure
	puts "Closing device"
	dev.close	
end