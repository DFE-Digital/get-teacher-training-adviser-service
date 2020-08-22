require "rails_helper"

RSpec.describe TeacherTrainingAdviser::Steps::PreviousTeacherId do
  include_context "wizard step"
  it_behaves_like "a wizard step"

  context "attributes" do
    it { is_expected.to respond_to :teacher_id }
  end

  describe "#skipped?" do
    it "returns false if returning_to_teaching is true and has_id is true" do
      wizardstore["returning_to_teaching"] = true
      wizardstore["has_id"] = true
      expect(subject).to_not be_skipped
    end

    it "returns true if has_id is false" do
      wizardstore["returning_to_teaching"] = true
      wizardstore["has_id"] = false
      expect(subject).to be_skipped
    end

    it "returns true if returning_to_teaching is false" do
      wizardstore["returning_to_teaching"] = false
      wizardstore["has_id"] = true
      expect(subject).to be_skipped
    end

    it "returns true if returning_to_teaching is false" do
      wizardstore["uk_or_overseas"] = false
      expect(subject).to be_skipped
    end
  end
end
