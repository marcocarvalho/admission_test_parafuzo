module ParkingLot
  module Errors
    class StandardError < ::StandardError; end
    class InvalidPlate  < StandardError; end
    class NotFound      < StandardError; end
    class NotPaid       < StandardError; end
  end
end