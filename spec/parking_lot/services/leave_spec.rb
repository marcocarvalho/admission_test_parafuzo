RSpec.describe ParkingLot::Services::Leave do
  subject { described_class.new(params) }
  let(:params) { { plate: plate } }
  let(:left) { false }

  context 'plate exists' do
    let(:plate) { 'AAA-9878' }
    let(:parking) { @parking }

    before(:each) do
      @parking = ParkingLot::Models::Parking.where(plate: plate, paid: paid, left: left).first_or_create
    end

    context 'paid' do
      let(:paid) { true }
      it 'leaves' do
        expect { subject.call }.to change { parking.reload.left }.from(false).to(true)
      end
    end

    context 'not paid' do
      let(:paid) { false }
      it 'does not leave' do
        expect { subject.call }.to raise_error(ParkingLot::Errors::NotPaid, "plate #{plate} not paid")
      end
    end
 end

  context 'plate does not exists' do
    let(:plate) { 'CCC-1178' }
    let(:left) { true }
    let(:paid) { true }

    it 'raises error' do
      expect { subject.call }.to raise_error(ParkingLot::Errors::NotFound, "plate #{plate} not found")
    end
  end
end