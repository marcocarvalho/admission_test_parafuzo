RSpec.describe ParkingLot::Serializers::Parking, type: :serializers do
  subject { described_class.new(model) }

  let(:entered_at) { Time.current }
  let(:model) { ParkingLot::Models::Parking.create(plate: 'bbb-9878', entered_at: entered_at) }

  it 'serializes' do
    expect(subject.to_json).to eq({ reservation: model._id.to_s.first(6), plate: 'BBB-9878', entered_at: entered_at }.to_json)
  end
end