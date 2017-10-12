require 'sinatra/base'

module ParkingLot
  class API < Sinatra::Base
    before do
      content_type 'application/json'
    end

    get '/' do
      { app: 'parking_lot', version: 1.0 }.to_json
    end

    post '/parking' do
      enter_service = ParkingLot.park(params).tap(&:call)
      render enter_service.parking, serializer: :parking
    end

    put '/parking/:plate/out' do
      leave_service = ParkingLot.leave(params).tap(&:call)
      render leave_service.parking, serializer: :no_content
    end

    put '/parking/:plate/pay' do
      pay_service = ParkingLot.pay(params).tap(&:call)
      render pay_service.parking, serializer: :no_content
    end

    get '/parking/:plate' do
      render ParkingLot.history(params).call, serializer: :history
    end

    error ParkingLot::Errors::NotPaid do
      [422, { errors: { plate: ["not paid"] } }.to_json ]
    end

    error ParkingLot::Errors::NotFound do
      [404, { errors: { plate: ['not found'] } }.to_json ]
    end

    error ParkingLot::Errors::InvalidPlate do
      [422, { errors: { plate: ["is invalid"] } }.to_json ]
    end

    protected

    def render model, serializer:
      if model.respond_to?(:each)
        [200, serialize_collection(model, serializer) ]
      elsif model.invalid?
        [422, serializer_for(:errors).new(model).to_json]
      elsif serializer == :no_content
        [204, nil]
      else
        serializer_for(serializer).new(model).to_json
      end
    end

    def serialize_collection(models, serializer)
      klass = serializer_for(serializer)
      models.map { |m| klass.new(m) }.to_json
    end

    def serializer_for(name)
      "parking_lot/serializers/#{name}".classify.constantize
    end
  end
end