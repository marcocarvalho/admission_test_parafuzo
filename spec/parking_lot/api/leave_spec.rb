RSpec.describe ParkingLot::API, type: :controller do
  context 'leave' do
    let(:plate) { 'BBC-1888' }
    let(:paid) { true }
    let(:left) { false }
    let(:parking) { @model }

    before(:each) do
      service = ParkingLot.park(plate: plate).tap(&:call)
      ParkingLot.pay(plate: plate).call if paid
      ParkingLot.leave(plate: plate).call if left
      @model = service.parking
    end

    shared_examples 'a good leave' do
      it 'leaves set left field' do
        expect { put "/parking/#{plate}/out" }.to change { parking.reload.left }.from(false).to(true)
      end
    end

    it_behaves_like 'a good leave'

    context 'mixed uppercase/downcase plate' do
      let(:plate) { 'Xye-5665' }
      it_behaves_like 'a good leave'
    end

    context 'response' do
      before(:each) do
        put "/parking/#{plate}/out"
      end

      it 'responds 204 - no content' do
        expect(last_response.status).to eq(204)
      end

      it 'returns no body' do
        expect(last_response.body).to be_empty
      end

      it 'return no content_type header when no_content' do
        expect(last_response.headers).not_to include('Content-Type')
      end
    end

    context 'errors' do
      context 'without a paid plate' do
        let(:paid) { false }

        it 'not found' do
          put "/parking/#{plate}/out"
          expect(last_response.status).to eq(422)
          expect(last_response.body).to eq({ errors: { plate: ['not paid'] } }.to_json)
        end
      end

      it 'not found' do
        put '/parking/ooo-9999/out'
        expect(last_response.status).to eq(404)
        expect(last_response.body).to eq({ errors: { plate: ['not found'] } }.to_json)
      end

      it 'is an invalid plate' do
        put '/parking/babababa/out'
        expect(last_response.status).to eq(422)
        expect(last_response.body).to eq({ errors: { plate: ['is invalid'] } }.to_json)
      end
    end
  end
end