require "rails_helper"

RSpec.describe TeacherTrainingAdviser::Steps::OverseasTelephone do
  include_context "wizard step"
  it_behaves_like "a wizard step"
  include_context "sanitize fields", %i[telephone]

  it { is_expected.to be_contains_personal_details }

  context "attributes" do
    it { is_expected.to respond_to :telephone }
  end

  describe "telephone" do
    it { is_expected.to_not allow_values("abc12345", "12", "1" * 21).for :telephone }
    it { is_expected.to allow_values(nil, "123456789").for :telephone }
  end

  describe "#skipped?" do
    it "returns false if uk_or_overseas is Overseas" do
      wizardstore["uk_or_overseas"] = TeacherTrainingAdviser::Steps::UkOrOverseas::OPTIONS[:overseas]
      expect(subject).to_not be_skipped
    end

    it "returns true if uk_or_overseas is UK" do
      wizardstore["uk_or_overseas"] = TeacherTrainingAdviser::Steps::UkOrOverseas::OPTIONS[:uk]
      expect(subject).to be_skipped
    end

    it "returns true if degree_options is equivalent is true" do
      wizardstore["degree_options"] = "equivalent"
      expect(subject).to be_skipped
    end
  end
end
