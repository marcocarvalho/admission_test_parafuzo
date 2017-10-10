module ParkingLot
  module Services
    class Base
      attr_accessor :params, :parking

      def initialize(params = {})
        @raw_params = params.with_indifferent_access
      end

      def errors
        parking.errors if parking.invalid?
      end

      def model
        ::ParkingLot::Models::Parking
      end

      def params
        @params ||= @raw_params.slice(*permitted_params)
      end

      def permitted_params
        []
      end
    end
  end
end