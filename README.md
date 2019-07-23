# aero-keyboard
Protocols and linux scripts for controlling the Gigabyte Aero 15 Keyboard backlight.

More background on the project can be found here: https://blockdev.io/gigabyte-aero-w15-keyboard-and-linux-ubuntu/

Note, a version for the 1044:7a39 Chu Yuen Enterprise Co., Ltd keyboard can be found here: https://github.com/paul-ridgway/aero-keyboard/tree/1044_7a39_Chu_Yuen_Enterprise_Co_Ltd

# Running

## udev

Make sure udev rules are set as per: https://blockdev.io/gigabyte-aero-w15-keyboard-and-linux-ubuntu/#usbpermissions


## Clone the Repo

```
paul@aero15 [08:53:30] [~/Documents/Code] 
-> % git clone git@github.com:paul-ridgway/aero-keyboard.git aero-tmp
Cloning into 'aero-tmp'...
remote: Enumerating objects: 98, done.
remote: Counting objects: 100% (98/98), done.
remote: Compressing objects: 100% (54/54), done.
remote: Total 98 (delta 44), reused 90 (delta 37), pack-reused 0
Receiving objects: 100% (98/98), 20.83 KiB | 10.41 MiB/s, done.
Resolving deltas: 100% (44/44), done.
```

## Ruby and Gems

If using rvm it will pick up the version and gemset, if not install ruby 2.6.0.

```
paul@aero15 [08:53:42] [~/Documents/Code] 
-> % cd aero-tmp 
ruby-2.6.0 - #gemset created /home/paul/.rvm/gems/ruby-2.6.0@aero-keyboard-2
ruby-2.6.0 - #generating aero-keyboard-2 wrappers - please wait
```

## Install Bundler

```
paul@aero15 [08:53:54] [~/Documents/Code/aero-tmp] [master *]
-> % gem install bundler
Fetching bundler-2.0.2.gem
Successfully installed bundler-2.0.2
Parsing documentation for bundler-2.0.2
Installing ri documentation for bundler-2.0.2
Done installing documentation for bundler after 2 seconds
1 gem installed
```

## Bundle Install

```
paul@aero15 [08:54:00] [~/Documents/Code/aero-tmp] [master *]
-> % bundle install
Fetching gem metadata from https://rubygems.org/..........
Using bundler 1.17.3
Fetching concurrent-ruby 1.1.4
Installing concurrent-ruby 1.1.4
Fetching ffi 1.9.25
Installing ffi 1.9.25 with native extensions
Fetching generate_method 1.0.0
Installing generate_method 1.0.0
Fetching i18n 1.3.0
Installing i18n 1.3.0
Fetching libusb 0.5.1
Installing libusb 0.5.1 with native extensions
Fetching hidapi 0.1.9
Installing hidapi 0.1.9
Fetching yinum 2.2.2
Installing yinum 2.2.2
Bundle complete! 2 Gemfile dependencies, 8 gems now installed.
Use `bundle info [gemname]` to see where a bundled gem is installed.
Post-install message from i18n:

HEADS UP! i18n 1.1 changed fallbacks to exclude default locale.
But that may break your application.

Please check your Rails app for 'config.i18n.fallbacks = true'.
If you're using I18n (>= 1.1.0) and Rails (< 5.2.2), this should be
'config.i18n.fallbacks = [I18n.default_locale]'.
If not, fallbacks will be broken in your app by I18n 1.1.x.

For more info see:
https://github.com/svenfuchs/i18n/releases/tag/v1.1.0
```
## Run an example

```
paul@aero15 [08:55:30] [~/Documents/Code/aero-tmp] [1044_7a39_Chu_Yuen_Enterprise_Co_Ltd]
-> % ./white.rb 
[#<HIDAPI::Device:0x00002ab4d1e085c0 046d:c318 VENDOR(0x046d) PRODUCT(0xc318) ? (CLOSED)>,
 #<HIDAPI::Device:0x00002ab4d1e08458 1044:7a39 HOLTEK USB-HID Keyboard AP0000000003 (CLOSED)>]
Opening device 1:4:3...
Closing device
```

Note here I switch to another branch that supports my device.