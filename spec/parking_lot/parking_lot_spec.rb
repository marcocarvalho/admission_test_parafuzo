RSpec.describe ParkingLot do
  subject { described_class }

  it { expect(subject.respond_to?(:enter)).to be_truthy }
  it { expect(subject.respond_to?(:pay)).to be_truthy }
  it { expect(subject.respond_to?(:leave)).to be_truthy }

  context 'module_functions call services' do
    let(:plate) { 'AAA-1234' }
    let(:params) { { plate: plate } }

    before(:each) do
      mock = double(:service)
      expect(service).to receive(:new).with(params).and_return(mock)
      expect(mock).to receive(:call).and_return(:result)
    end

    context 'enter' do
      let(:service) { ParkingLot::Services::Enter }
      it { expect(subject.enter(plate: plate)).to eq(:result) }
    end

    context 'pay' do
      let(:service) { ParkingLot::Services::Pay }
      it { expect(subject.pay(plate: plate)).to eq(:result) }
    end

    context 'leave' do
      let(:service) { ParkingLot::Services::Leave }
      it { expect(subject.leave(plate: plate)).to eq(:result) }
    end
  end
end