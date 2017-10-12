RSpec.describe ParkingLot::Services::Park do
  subject { described_class.new(params) }

  let(:params) { { plate: 'aaa-9999' } }

  it 'creates' do
    expect { subject.call }.to change { ParkingLot::Models::Parking.where(plate: 'AAA-9999').count }.by(1)
  end

  context 'alreary parked' do
    before(:each) do
      service = described_class.new(params)
      service.call
      @persisted_plate = service.parking
    end

    let(:params) { { plate: 'bbb-9999' } }

    it 'do not create and show error' do
      expect { subject.call }.not_to change { ParkingLot::Models::Parking.where(plate: 'BBB-9999').count }
      expect(subject.errors).to be_present
      expect(subject.errors[:plate]).to include('already parked')
    end

    it 'saves if plate already left' do
      @persisted_plate.update!(left: true, paid: true, left_at: Time.new)
      expect { subject.call }.to change { ParkingLot::Models::Parking.where(plate: 'BBB-9999').count }.by(1)
    end
  end
end