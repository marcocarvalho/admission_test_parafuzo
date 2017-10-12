module ParkingLot
  module Serializers
    class Base
      include ActiveModel::Serialization
      include ActiveModel::Serializers::JSON

      attr_accessor :model

      def initialize(model)
        @model = model
      end

      def reservation
        model._id.to_s.first(6)
      end

    end
  end
end