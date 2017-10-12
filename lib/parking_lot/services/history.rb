module ParkingLot
  module Services
    class History < Base
      def call
        @parking = model.where(coerced_params)
      end

      alias_method :parkings, :parking
    end
  end
end