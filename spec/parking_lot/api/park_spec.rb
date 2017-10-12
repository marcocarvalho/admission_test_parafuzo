RSpec.describe ParkingLot::API, type: :controller do
  context 'parking' do
    let(:plate) { 'BBB-9999' }

    context 'new plate' do
      before(:each) do
        post '/parking', { plate: plate }
      end
      it 'responds 200' do
        expect(last_response).to be_ok
      end

      it 'returns body with parking information' do
        model = ParkingLot::Models::Parking.where(plate: 'BBB-9999').first
        expect(last_response.body).to eq(ParkingLot::Serializers::Parking.new(model).to_json)
      end

      it 'return json content_type' do
        expect(last_response.headers["Content-Type"]).to eq('application/json')
      end
    end

    context 'errors' do
      it 'already parked' do
        service = ParkingLot.park(plate: plate).tap(&:call)
        post '/parking', { plate: plate }
        expect(last_response.status).to eq(422)
        expect(last_response.body).to eq({ errors: { plate: ['already parked'] } }.to_json)
      end

      it 'is an invalid plate' do
        post '/parking', { plate: 'babababa' }
        expect(last_response.status).to eq(422)
        expect(last_response.body).to eq({ errors: { plate: ['is invalid'] } }.to_json)
      end
    end
  end
end