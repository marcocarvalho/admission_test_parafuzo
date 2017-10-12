RSpec.describe ParkingLot do
  subject { described_class }

  it { expect(subject.respond_to?(:park)).to be_truthy }
  it { expect(subject.respond_to?(:pay)).to be_truthy }
  it { expect(subject.respond_to?(:leave)).to be_truthy }

  context 'module_functions call services' do
    let(:plate) { 'AAA-1234' }
    let(:params) { { plate: plate } }

    before(:each) do
      expect(service).to receive(:new).with(params).and_return(:service)
    end

    context 'enter' do
      let(:service) { ParkingLot::Services::Park }
      it { expect(subject.park(plate: plate)).to eq(:service) }
    end

    context 'pay' do
      let(:service) { ParkingLot::Services::Pay }
      it { expect(subject.pay(plate: plate)).to eq(:service) }
    end

    context 'leave' do
      let(:service) { ParkingLot::Services::Leave }
      it { expect(subject.leave(plate: plate)).to eq(:service) }
    end
  end
end