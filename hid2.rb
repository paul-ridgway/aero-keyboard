#!/usr/bin/env ruby

require 'libusb'
require 'pry'

VENDOR = 0x04d9
PRODUCT = 0x8008
#ENDPOINT = 0x04
data = "\xaa\xaa\x62\x00\x04\x00\xff\x00\x00".force_encoding(Encoding::BINARY)

usb = LIBUSB::Context.new
usb.debug = 10

devices = usb.devices(idVendor: VENDOR, idProduct: PRODUCT)
device = devices.first

raise 'No device found' unless device

begin
  endpoint_in = device.endpoints.find { |ep| !(ep.bEndpointAddress & LIBUSB::ENDPOINT_IN).zero? }
  endpoint_out = device.endpoints.find { |ep| (ep.bEndpointAddress & LIBUSB::ENDPOINT_IN).zero? }
  # binding.pry

  puts 'endpoint_in'
  pp endpoint_in
  puts
  puts 'endpoint_out'
  pp endpoint_out
  puts

  h = device.open
  h.auto_detach_kernel_driver = true
  h.claim_interface(0)
  h.clear_halt endpoint_in
  response = h.interrupt_transfer(
    endpoint: endpoint_out,
    dataOut: data,
    timeout: 10000
  )

  p response
ensure
  h.release_interface(0)
  h.close
end