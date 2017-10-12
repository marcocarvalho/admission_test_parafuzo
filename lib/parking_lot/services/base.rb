module ParkingLot
  module Services
    class Base
      attr_accessor :params, :parking

      def initialize(params = {})
        @raw_params = params.with_indifferent_access
        invalid_plate! unless valid_plate?
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

      def coerced_params
        @coerced_params ||= params.merge(plate: params[:plate].upcase)
      end

      def permitted_params
        %i(plate)
      end

      def valid_plate?
        params[:plate] =~ ::ParkingLot::Models::Parking::PLATE_REGEX
      end

      protected

      def invalid_plate!
        raise ParkingLot::Errors::InvalidPlate.new("plate #{params[:plate]} is invalid")
      end

      def not_found!
        raise ParkingLot::Errors::NotFound.new("plate #{params[:plate]} not found")
      end
    end
  end
end