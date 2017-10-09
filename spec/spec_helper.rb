require 'rack/test'
require 'rspec'
require 'mongoid-rspec'

ENV['RACK_ENV'] = 'test'

require File.expand_path('../boot.rb', File.dirname(__FILE__))

module RSpecMixin
  include Rack::Test::Methods
  def app; ParkingLot::API; end
end

RSpec.configure do |config|
  config.include RSpecMixin, type: :controller
  config.include Mongoid::Matchers, type: :model
end