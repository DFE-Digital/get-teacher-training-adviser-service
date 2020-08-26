require "rails_helper"

RSpec.describe TeacherTrainingAdviser::Steps::UkTelephone do
  include_context "wizard step"
  it_behaves_like "a wizard step"

  it { is_expected.to be_contains_personal_details }

  context "attributes" do
    it { is_expected.to respond_to :telephone }
  end

  describe "telephone" do
    it { is_expected.to_not allow_values("abc12345", "12", "1" * 21).for :telephone }
    it { is_expected.to allow_values(nil, "123456789").for :telephone }
  end

  describe "#skipped?" do
    it "returns false if uk_or_overseas is UK" do
      wizardstore["uk_or_overseas"] = TeacherTrainingAdviser::Steps::UkOrOverseas::OPTIONS[:uk]
      expect(subject).to_not be_skipped
    end

    it "returns true if returning_to_teaching is Overseas" do
      wizardstore["uk_or_overseas"] = TeacherTrainingAdviser::Steps::UkOrOverseas::OPTIONS[:overseas]
      expect(subject).to be_skipped
    end
  end
end