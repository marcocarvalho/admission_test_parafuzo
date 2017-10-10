module ParkingLot
  module Models
    class Parking
      include Mongoid::Document
      include Mongoid::Timestamps

      field :plate, type: String
      field :paid, type: Boolean, default: false
      field :left, type: Boolean, default: false
      field :enter_at, type: DateTime, default: -> { Time.now }
      field :left_at, type: DateTime


      validates :plate, presence: true
      validates :plate, format: { with: /[a-z]{3}-\d{4}/i }
      validates :left_at, presence: true, if: :left

      validate :plate_uniqueness, on: :create

      before_validation :upcase_plate

      index plate: 1

      private

      def plate_uniqueness
        if self.class.where(plate: plate, left: false).count > 0
          errors.add(:plate, 'already entered')
        end
      end

      def upcase_plate
        plate.upcase! if plate.present?
      end
    end
  end
end