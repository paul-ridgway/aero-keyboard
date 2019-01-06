#!/usr/bin/env ruby

require 'libusb'

VENDOR = 0x04d9
PRODUCT = 0x8008
INTERFACE = 0

usb = LIBUSB::Context.new
usb.debug = 4

puts "Find device"
device = usb.devices(idVendor: VENDOR, idProduct: PRODUCT).first

unless device
	puts "Device not found, exiting!"
end

reattach = false

begin
	puts "Aquire handle"
	handle = device.open
	if handle.kernel_driver_active?(INTERFACE)
		sleep 1
		puts "Kernel driver attached, detatching"
		reattach = true
		handle.detach_kernel_driver(INTERFACE)
	end
	sleep 1
	puts "Claim interface"
	handle.claim_interface(INTERFACE)

	pp device.endpoints
	pp device.endpoints.map(&:bEndpointAddress)


	# puts "Clear halt"
	# handle.clear_halt(INTERFACE)

	sleep 3

	puts "Do Work!"
	handle.control_transfer(bmRequestType: 0xa1, bRequest: 0x01, wValue: 0x03, wIndex: 0x0003, dataIn: 8) do |res|
		pp res
	end
	# handle.control_transfer(bmRequestType: 0x21, bRequest: 0x09, wValue: 0x0300, wIndex: 0x0003, dataOut: '') do |res|
	# 	pp res
	# end

	sleep 3

rescue => e
	puts
	puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!1"
	puts "Error: #{e.message}"
	puts e.backtrace
	puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!1"
	puts
ensure
	puts "Release interface"
	handle.release_interface(INTERFACE)
	sleep 1

	if reattach
		puts "Re-attaching kernel driver"
		handle.attach_kernel_driver(INTERFACE)
  		sleep 1
	end

	puts "Close"
	handle.close
end