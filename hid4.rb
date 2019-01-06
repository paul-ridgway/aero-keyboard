#!/usr/bin/env ruby

require 'hidapi'

bus_number = 1
device_address = 4
interface = 3

SOLID_GRN      = [0x08, 0x00, 0x01, 0x06, 0x32, 0x02, 0x01, 0xbb] #bb
PRESS_FADE_GRN = [0x08, 0x00, 0x04, 0x0a, 0x32, 0x02, 0x01, 0xb4] #b4 
PRESS_FADE_YEL = [0x08, 0x00, 0x04, 0x0a, 0x32, 0x03, 0x01, 0xb3] #b3
MARQUEE        = [0x08, 0x00, 0x05, 0x06, 0x32, 0x01, 0x01, 0xb8] #b8

begin
	dev = HIDAPI::open_path("#{bus_number.to_s(16)}:#{device_address.to_s(16)}:#{interface.to_s(16)}")
	dev.send_feature_report PRESS_FADE_YEL.pack('c*')
	sleep 2
	dev.send_feature_report SOLID_GRN.pack('c*')
	sleep 2
	dev.send_feature_report MARQUEE.pack('c*')
	sleep 2
	dev.send_feature_report PRESS_FADE_GRN.pack('c*')
rescue Exception => e
	puts "Error: #{e.message}"
	puts e.backtrace
ensure
	puts "Closing device"
	dev.close	
end