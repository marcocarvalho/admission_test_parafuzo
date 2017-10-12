RSpec.describe ParkingLot::API, type: :controller do
  let(:parking1) { @model1 }
  let(:plate) { 'aaa-9999' }

  before(:each) do
    one_day_ago = 1.day.ago
    @model1 =
      ParkingLot::Models::Parking.create!(
        plate: plate,
        left: true,
        paid: true,
        entered_at: one_day_ago,
        left_at: one_day_ago + 1.hour)

    get '/parking/aaa-9999'
  end

  it 'response to be ok' do
    expect(last_response).to be_ok
  end

  it 'content type to json' do
    expect(last_response.headers['Content-Type']).to eq('application/json')
  end

  it 'serializes' do
    expect(last_response.body).to eq([ParkingLot::Serializers::History.new(parking1)].to_json)
  end
end