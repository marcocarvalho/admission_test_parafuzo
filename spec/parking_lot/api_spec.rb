RSpec.describe ParkingLot::API, type: :controller do
  it 'gets /parking/:plate' do
    get '/parking/aaa-9999'
    expect(last_response).to be_ok
  end

  context 'parking' do
    context 'new plate' do
      before(:each) do
        post '/parking', { plate: 'bbb-9999' }
      end

      it 'responds 200' do
        expect(last_response).to be_ok
      end

      it 'returns body with parking information' do
      end
    end
  end
end