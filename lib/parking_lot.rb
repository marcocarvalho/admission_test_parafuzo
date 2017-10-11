require 'parking_lot/api'
require 'parking_lot/database'
require 'parking_lot/errors'
require 'parking_lot/models/parking'
require 'parking_lot/services'
require 'parking_lot/serializers'

module ParkingLot
  module_function
    def pay(params)
      Services::Pay.new(params)
    end

    def leave(params)
      Services::Leave.new(params)
    end

    def enter(params)
      Services::Enter.new(params)
    end
end