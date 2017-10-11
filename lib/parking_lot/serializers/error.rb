module ParkingLot
  module Serializers
    class Error < Base
      delegate :errors, to: :model

      def attributes
        {
          errors: nil
        }
      end
    end
  end
end