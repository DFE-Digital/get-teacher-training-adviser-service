RSpec.shared_examples "#address_telephone_value" do
  describe "#address_telephone_value" do
    subject { instance.address_telephone_value }

    before do
      instance.address_telephone = address_telephone
      double = double("overseas_country")
      allow(double).to receive(:dial_in_code) { "44" }
      allow(instance).to receive(:other_step).with(:overseas_country) { double }
    end

    context "when address_telephone is present" do
      let(:address_telephone) { "123456789" }

      it { is_expected.to eq(address_telephone) }
    end

    context "when address_telephone is not present" do
      let(:address_telephone) { nil }

      it { is_expected.to eq("44") }
    end
  end
end
