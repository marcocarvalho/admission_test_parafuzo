module ParkingLot
  module Services
    class Pay < Base
      def call
        find_entity || not_found
        parking.update!(paid: true)
      end

      def find_entity
        @parking = model.where(params.merge(paid: false, left: false)).first
      end

      private

      def not_found
        raise ParkingLot::Errors::NotFound.new("plate #{params[:plate]} not found")
      end
    end
  end
end