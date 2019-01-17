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
      current_configuration.map {|k, v| "#{k.to_s.capitalize}: #{(defined? v.name) ? v.name : v}"}
    end

    def set_configuration(animation, speed, brightness, colour)
      data = [0x08, 0x00, animation, speed, brightness, colour, 0x01]
      @device.send_feature_report(wrap(data))
    end

    def custom_map(custom_index, brightness, map)
      # TODO Check config range

      layout = Array.new(129, [0, 0, 0])

      map.each do |key, colour|
        # TODO: Validation
        # TODO: Support groups

        if key.is_a?(Array)
          key.each {|k| layout[k.to_i] = colour}
        elsif key.is_a?(Integer)
          layout[key.to_i] = colour
        else
          raise "Unexpected key: #{key}"
        end
      end

      set_configuration(Keyboard::ANIMATIONS.custom_1 + custom_index, 0, brightness, Keyboard::COLOURS.red)
      start_programming(custom_index)
      8.times do |i|
        start = i * 16
        data = []
        16.times do |j|
          idx = start + j + 1
          r, g, b = layout[idx]
          data += [idx, r, g, b]
        end
        puts "Write #{i}, len: #{data.size}, start: #{start}"
        puts
        puts pretty_hex(data)
        puts
        @device.write(data.pack('c*'))
      end

      #     TODO: Read resonse?
      # puts "Reading..."
      # read = dev.read
      # puts "Read: #{read}"


      set_configuration(Keyboard::ANIMATIONS.custom_1 + custom_index, 0, brightness, Keyboard::COLOURS.red)
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

    def pretty_hex(data)
      data = data.bytes if data.is_a? String
      data.map {|b| sprintf("0x%02X", b)}.join(', ')
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

    def start_programming(custom_index)
      @device.send_feature_report(wrap([0x12, 0x00, custom_index, 0x08, 0x00, 0x00, 0x00]))
    end

  end
end
