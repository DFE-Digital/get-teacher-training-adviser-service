require "rails_helper"

RSpec.describe TeacherTrainingAdviser::Steps::AlreadySignedUp do
  include_context "wizard step"
  it_behaves_like "a wizard step"

  it { is_expected.to_not be_can_proceed }

  describe "#skipped?" do
    it "returns true if already_subscribed_to_teacher_training_adviser is false/nil/undefined" do
      expect(subject).to be_skipped
      wizardstore["already_subscribed_to_teacher_training_adviser"] = nil
      expect(subject).to be_skipped
      wizardstore["already_subscribed_to_teacher_training_adviser"] = false
      expect(subject).to be_skipped
    end

    it "returns false if already_subscribed_to_teacher_training_adviser is true" do
      wizardstore["already_subscribed_to_teacher_training_adviser"] = true
      expect(subject).to_not be_skipped
    end
  end
end
