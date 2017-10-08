require 'rack/test'
require 'rspec'
require File.expand_path('../boot.rb', File.dirname(__FILE__))

ENV['RACK_ENV'] = 'test'

module RSpecMixin
  include Rack::Test::Methods
  def app; ParkingLot::API; end
end

RSpec.configure { |c| c.include RSpecMixin }