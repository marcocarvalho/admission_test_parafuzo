RSpec.describe ParkingLot::Services::History do
  subject { described_class.new(params) }
  let(:params) { { plate: plate } }
  let(:create_plate) { plate }

  let(:parking1) { @model1 }
  let(:parking2) { @model2 }
  let(:parking3) { @model3 }

  before(:each) do
    two_days_ago = 2.days.ago
    one_day_ago = 1.day.ago
    defaults = { plate: create_plate, left: true, paid: true }
    @model1 =
      ParkingLot::Models::Parking.create!(
        entered_at: two_days_ago,
        left_at: two_days_ago + 1.hour,
        **defaults)
    @model2 =
      ParkingLot::Models::Parking.create!(
        entered_at: one_day_ago,
        left_at: one_day_ago + 2.hour,
        **defaults)
    @model3 = ParkingLot::Models::Parking.create!(plate: create_plate)
  end

  context 'plate exists' do
    let(:plate) { 'AAA-9878' }
    let(:parkings) { [parking1, parking2, parking3] }

    it 'list only paid and left entities' do
      expect(subject.call).to match_array(parkings)
    end

    it 'respond to parkings' do
      expect(subject.call).to be(subject.parkings)
    end
 end

  context 'plate does not exists' do
    let(:plate) { 'CCC-1178' }
    let(:create_plate) { 'AAA-1234' }

    it 'returns empty' do
      expect(subject.call).to match_array([])
    end
  end

  context 'invalid plate' do
    let(:plate) { 'xaxaxaxa' }
    let(:create_plate) { 'AAA-1234' }
    it { expect{ subject.call }.to raise_error(ParkingLot::Errors::InvalidPlate) }
  end
end