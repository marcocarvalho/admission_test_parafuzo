module ParkingLot
  module Serializers
    class Base
      include ActiveModel::Serialization
      include ActiveModel::Serializers::JSON

      attr_accessor :model

      def initialize(model)
        @model = model
      end
    end
  end
end