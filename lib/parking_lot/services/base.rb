module ParkingLot
  module Services
    class Base
      attr_accessor :params, :parking

      def initialize(params = {})
        @params = params
      end

      def errors
        parking.errors if parking.invalid?
      end
    end
  end
end