require "rails_helper"

RSpec.describe TeacherTrainingAdviser::Steps::UkAddress do
  include_context "wizard step"
  it_behaves_like "a wizard step"
  include_context "sanitize fields", %i[address_line1 address_line2 address_city address_postcode]

  it { is_expected.to be_contains_personal_details }

  context "attributes" do
    it { is_expected.to respond_to :address_line1 }
    it { is_expected.to respond_to :address_line2 }
    it { is_expected.to respond_to :address_city }
    it { is_expected.to respond_to :address_postcode }
  end

  describe "#address_line1" do
    it { is_expected.not_to allow_values("", nil, "a" * 1025).for :address_line1 }
    it { is_expected.to allow_values("7", "7 Main Street").for :address_line1 }
  end

  describe "#address_line2" do
    it { is_expected.not_to allow_values("a" * 1025).for :address_line2 }
  end

  describe "#address_city" do
    it { is_expected.not_to allow_values("", nil, "a" * 129).for :address_city }
    it { is_expected.to allow_value("Manchester").for :address_city }
  end

  describe "#address_postcode" do
    it { is_expected.not_to allow_values("", nil).for :address_postcode }
    it { is_expected.to allow_values("eh3 9eh", "TR1 1XY", "hs13eq").for :address_postcode }
  end

  describe "#skipped?" do
    it "returns false if uk_or_overseas is UK" do
      wizardstore["uk_or_overseas"] = TeacherTrainingAdviser::Steps::UkOrOverseas::OPTIONS[:uk]
      expect(subject).not_to be_skipped
    end

    it "returns true if returning_to_teaching is Overseas" do
      wizardstore["uk_or_overseas"] = TeacherTrainingAdviser::Steps::UkOrOverseas::OPTIONS[:overseas]
      expect(subject).to be_skipped
    end
  end

  describe "#reviewable_answers" do
    subject { instance.reviewable_answers }

    before do
      instance.address_line1 = "Address 1"
      instance.address_line2 = "Address 2"
      instance.address_city = "City"
      instance.address_postcode = "TE7 8JT"
    end

    it { is_expected.to eq({ "address" => "Address 1\nAddress 2\nCity\nTE7 8JT" }) }
  end
end
