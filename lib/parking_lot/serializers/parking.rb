module ParkingLot
  module Serializers
    class Parking < Base
      delegate :plate, :entered_at, to: :model

      def reservation
        model._id.to_s.first(6)
      end

      def attributes
        {
          reservation: nil,
          plate: nil,
          entered_at: nil
        }
      end
    end
  end
end