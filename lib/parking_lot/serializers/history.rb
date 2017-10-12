module ParkingLot
  module Serializers
    class History < Base
      delegate :plate, :paid, :left, to: :model

      def time
        human_time(used_time)
      end

      # DateTime return sub and add operations in days.
      # http://ruby-doc.org/stdlib-2.0.0/libdoc/date/rdoc/Date.html#method-i-2D
      def used_time
        (model.left_at || Time.current).to_time - model.entered_at.to_time
      end

      def attributes
        {
          time: nil,
          paid: nil,
          left: nil,
          plate: nil,
          reservation: nil
        }
      end

      def human_time(duration)
        case duration
        when 0..59
          "#{duration} seconds"
        when 60
          "1 minute"
        when 61..3599
          "#{duration / 60} minutes"
        when 3600
          "1 hour"
        when 3601..86399
          "#{duration / 1.hour} hours #{duration % 1.hour / 60} minutes"
        when 86400
          "1 day"
        else
          "#{duration / 1.day} days #{duration % 1.day / 1.hour} hours"
        end
      end
    end
  end
end