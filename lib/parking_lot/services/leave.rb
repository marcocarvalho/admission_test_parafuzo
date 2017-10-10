module ParkingLot
  module Services
    class Leave < Base
      def call
        find_entity || not_paid? || not_found!
        parking.update!(left: true, left_at: Time.now)
      end

      def find_entity
        @parking = model.where(params.merge(paid: true, left: false)).first
      end

      private

      def not_paid?
        if model.where(params.merge(paid: false, left: false)).first
          raise ParkingLot::Errors::NotPaid.new("plate #{params[:plate]} not paid")
        end
      end
    end
  end
end