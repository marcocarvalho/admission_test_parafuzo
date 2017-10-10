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
        %i(plate)
      end

      protected

      def not_found!
        raise ParkingLot::Errors::NotFound.new("plate #{params[:plate]} not found")
      end
    end
  end
end