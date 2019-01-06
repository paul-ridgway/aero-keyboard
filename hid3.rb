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