module ParkingLot
  module Errors
    class StandardError < ::StandardError; end
    class NotFound < StandardError; end
  end
end