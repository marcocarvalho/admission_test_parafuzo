require 'sinatra/base'

module ParkingLot
  class API < Sinatra::Base
    before do
      content_type 'application/json'
    end

    post '/parking' do
      enter_service = ParkingLot.park(params)
      enter_service.call
      render enter_service.parking, serializer: :parking
    end

    put '/parking/:plate/out' do
      leave_service = ParkingLot.leave(params)
      leave_service.call
      render leave_service.parking, serializer: :leave
    end

    put '/parking/:plate/pay' do
      pay_service = ParkingLot.pay(params)
      pay_service.call
      render pay_service.parking, serializer: :pay
    end

    get '/parking/:plate' do
      '{}'
    end

    protected

    def render model, serializer:
      if model.invalid?
        [422, serializer_for(:errors).new(model).to_json]
      else
        serializer_for(serializer).new(model).to_json
      end
    end

    def serializer_for(name)
      "parking_lot/serializers/#{name}".classify.constantize
    end
  end
end