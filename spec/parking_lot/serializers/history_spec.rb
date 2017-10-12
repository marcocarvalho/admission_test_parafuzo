RSpec.describe ParkingLot::Serializers::History, type: :serializers do
  subject { described_class.new(model) }

  let(:entered_at) { Time.current }
  let(:model) { ParkingLot::Models::Parking.create(plate: 'bbb-9878', entered_at: entered_at, left_at: entered_at + 1.hour, paid: true, left: true) }

  it { expect(subject.to_json).to eq({
          time: '1 hour',
          paid: model.paid,
          left: model.left,
          plate: model.plate,
          reservation: model._id.to_s.first(6)
        }.to_json) }

  context 'human time' do
    it { expect(subject.human_time(1.day)).to eq('1 day') }
    it { expect(subject.human_time(1.hour)).to eq('1 hour') }
    it { expect(subject.human_time(1.minute)).to eq('1 minute') }
    it { expect(subject.human_time(15.minutes + 59.seconds)).to eq('15 minutes') }
    it { expect(subject.human_time(10.hour + 59.minutes)).to eq('10 hours 59 minutes') }
    it { expect(subject.human_time(4.days + 23.hour + 15.minutes)).to eq('4 days 23 hours') }
  end
end