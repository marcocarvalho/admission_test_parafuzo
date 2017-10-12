module ParkingLot
  module Services
    class Park < Base
      def call
        build_entity
        parking.valid? && parking.save
      end

      def build_entity
        @parking = model.new(params)
      end
    end
  end
end