require "rails_helper"

RSpec.describe TeacherTrainingAdviser::Steps::OverseasTelephone do
  include_context "wizard step"
  it_behaves_like "a wizard step"
  include_context "sanitize fields", %i[address_telephone]

  it { is_expected.to be_contains_personal_details }
  it { is_expected.to be_optional }

  context "attributes" do
    it { is_expected.to respond_to :address_telephone }
  end

  describe "address_telephone" do
    it { is_expected.to_not allow_values("abc12345", "12", "1" * 21).for :address_telephone }
    it { is_expected.to allow_values(nil, "123456789").for :address_telephone }
  end

  describe "#skipped?" do
    it "returns false if OverseasCountry was shown and they don't have an equivalent degree" do
      expect_any_instance_of(TeacherTrainingAdviser::Steps::OverseasCountry).to receive(:skipped?) { false }
      wizardstore["degree_options"] = TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_OPTIONS[:yes]
      expect(subject).to_not be_skipped
    end

    it "returns true if OverseasCountry was skipped" do
      expect_any_instance_of(TeacherTrainingAdviser::Steps::OverseasCountry).to receive(:skipped?) { true }
      expect(subject).to be_skipped
    end

    it "returns true if degree_options is equivalent" do
      wizardstore["degree_options"] = TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_OPTIONS[:equivalent]
      expect(subject).to be_skipped
    end

    it "returns true when pre-filled with crm data" do
      wizardstore["degree_options"] = TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_OPTIONS[:yes]
      wizardstore.persist_crm({ "address_telephone" => "123456789" })
      expect(subject).to be_skipped
    end
  end
end
