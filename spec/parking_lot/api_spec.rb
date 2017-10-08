RSpec.describe ParkingLot::API do
  it 'gets /parking/:plate' do
    get '/parking/aaa-9999'
    expect(last_response).to be_ok
  end
end