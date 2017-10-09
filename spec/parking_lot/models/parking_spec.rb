RSpec.describe ParkingLot::Models::Parking, type: :model do
  it { is_expected.to be_mongoid_document }
  it { is_expected.to have_index_for(plate: 1) }

  describe 'fields' do
    it { is_expected.to have_field(:plate).of_type(String) }
    it { is_expected.to have_field(:paid).of_type(Mongoid::Boolean).with_default_value_of(false) }
    it { is_expected.to have_field(:left).of_type(Mongoid::Boolean).with_default_value_of(false) }
    it { is_expected.to have_field(:enter_at).of_type(DateTime) }
    it { is_expected.to have_field(:left_at).of_type(DateTime) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:plate) }
    it { is_expected.to validate_presence_of(:left_at) }
    it { is_expected.to validate_format_of(:plate).to_allow("aaa-9999").not_to_allow("aaa9999") }
    it { is_expected.to validate_format_of(:plate).to_allow("BBB-5555").not_to_allow("B9B-A999") }

    it 'validate left_at presence only if already left' do
      subject.left = true
      subject.left_at = nil
      expect(subject).not_to be_valid
      expect(subject.errors['left_at']).to include('can\'t be blank')

      subject.left_at = Time.now
      subject.valid?
      expect(subject.errors['left_at']).not_to include('can\'t be blank')
    end

    it 'upcases plate after validation' do
      subject.plate = 'aaa-9999'
      subject.valid?
      expect(subject.plate).not_to eq('aaa-9999')
      expect(subject.plate).to eq('AAA-9999')
    end
  end
end