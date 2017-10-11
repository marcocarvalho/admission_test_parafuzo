module ParkingLot
  module Serializers
    class Parking
      include ActiveModel::Serialization
      include ActiveModel::Serializers::JSON

      attr_accessor :model

      delegate :plate, :entered_at, to: :model

      def initialize(model)
        @model = model
      end

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