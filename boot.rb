dir = File.expand_path('./lib', File.dirname(__FILE__))

$LOAD_PATH.unshift(dir) unless $LOAD_PATH.include?(dir)

require 'bundler'
Bundler.setup

require 'parking_lot'