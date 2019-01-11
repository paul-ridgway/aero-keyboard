require 'hidapi'
require 'yinum'

module Keyboard
  class Device

    def initialize(bus_number, device_address, interface)
      puts "Opening device #{bus_number}:#{device_address}:#{interface}..."
      @device = HIDAPI::open_path("#{bus_number.to_s(16)}:#{device_address.to_s(16)}:#{interface.to_s(16)}")
    end

    def current_configuration
      data = @device.get_feature_report(1).bytes
      {
          animation: ANIMATIONS[data[2]],
          speed: data[3],
          brightness: data[4],
          colour: COLOURS[data[5]]
      }
    end

    def current_configuration_pretty
      current_configuration.map { |k, v| "#{k.to_s.capitalize}: #{(defined? v.name) ? v.name : v}"}
    end

    def set_configuration(animation, speed, brightness, colour)
      data = [0x08, 0x00, animation, speed, brightness, colour, 0x01]
      @device.send_feature_report(wrap(data))
    end

    def close
      @device.close
    end

    def self.find
      if (device = HIDAPI.enumerate.select {|device| device.vendor_id == 0x04d9 && device.product_id == 0x8008}.first)
        usb_device = device.usb_device
        return Device.new(usb_device.bus_number, usb_device.device_address, 3)
      end
      nil
    end

    private
    def print_hex(data)
      data = data.bytes if data.is_a? String
      data.map {|b| sprintf(", 0x%02X", b)}.join
    end

    def checksum(data)
      255 - data.sum
    end

    def checksum_packet(data)
      (data + [checksum(data)])
    end

    def wrap(data)
      checksum_packet(data).pack('c*')
    end


  end
end
