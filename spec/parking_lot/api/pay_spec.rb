RSpec.describe ParkingLot::API, type: :controller do
  context 'pay' do
    let(:plate) { 'BBB-8888' }

    shared_examples 'a good payment' do
      it 'pays!' do
        expect{ put "/parking/#{plate}/pay" }.to change { parking.reload.paid }.from(false).to(true)
      end
    end

    context 'with already parked plate' do
      let(:parking) { @model }

      before(:each) do
        service = ParkingLot.park(plate: plate)
        service.call
        @model = service.parking
      end

      it_behaves_like 'a good payment'

      context 'mixed uppercase/downcase plate' do
        let(:plate) { 'Xye-5665' }
        it_behaves_like 'a good payment'
      end

      context 'response' do
        before(:each) do
          put "/parking/#{plate}/pay"
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

    end

    context 'errors' do
      it 'not found' do
        put '/parking/ooo-9999/pay'
        expect(last_response.status).to eq(404)
        expect(last_response.body).to eq({ errors: { plate: ['not found'] } }.to_json)
      end

      it 'is an invalid plate' do
        put '/parking/babababa/pay'
        expect(last_response.status).to eq(422)
        expect(last_response.body).to eq({ errors: { plate: ['is invalid'] } }.to_json)
      end
    end
  end
end