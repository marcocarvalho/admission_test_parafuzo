RSpec.describe ParkingLot::Services::Pay do
  subject { described_class.new(params) }
  let(:params) { { plate: plate } }

  context 'plate exists' do
    let(:plate) { 'AAA-9878' }
    let(:paid) { false }
    let(:parking) { @parking }

    before(:each) do
      @parking = ParkingLot::Models::Parking.where(plate: plate, paid: paid).first_or_create
    end

    it 'pays' do
      expect { subject.call }.to change { parking.reload.paid }.from(false).to(true)
    end

    context 'do not paid already paid entity' do
      let(:paid) { true }

      it 'does not pay' do
        expect { subject.call }.to raise_error(ParkingLot::Errors::NotFound, "plate #{plate} not found")
      end
    end
  end

  context 'plate does not exists' do
    let(:plate) { 'CCC-1178' }
    it 'raises error' do
      expect { subject.call }.to raise_error(ParkingLot::Errors::NotFound, "plate #{plate} not found")
    end
  end
end