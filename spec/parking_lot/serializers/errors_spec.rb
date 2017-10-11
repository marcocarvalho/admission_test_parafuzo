RSpec.describe ParkingLot::Serializers::Error, type: :serializers do
  subject { described_class.new(model) }

  let(:entered_at) { Time.current }
  let(:model) { ParkingLot::Models::Parking.create(plate: 'bbbbbbb') }

  it 'serializes' do
    expect(subject.to_json).to eq({ errors: { plate: ['is invalid'] } }.to_json)
  end
end