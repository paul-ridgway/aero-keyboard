require_relative 'keyboard/keys'
require_relative 'keyboard/animations'
require_relative 'keyboard/colours'
require_relative 'keyboard/device'

module Keyboard

  public

  def self.open
    Device.find || raise("The keyboard could not be found")
  end
end
