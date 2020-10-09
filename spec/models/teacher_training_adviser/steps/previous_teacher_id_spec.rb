require "rails_helper"

RSpec.describe TeacherTrainingAdviser::Steps::PreviousTeacherId do
  include_context "wizard step"
  it_behaves_like "a wizard step"

  context "attributes" do
    it { is_expected.to respond_to :teacher_id }
  end

  describe "#skipped?" do
    it "returns false if HasTeacherId was shown and they selected yes" do
      expect_any_instance_of(TeacherTrainingAdviser::Steps::HasTeacherId).to receive(:skipped?) { false }
      wizardstore["has_id"] = true
      expect(subject).to_not be_skipped
    end

    it "returns true if HasTeacherId was skipped" do
      expect_any_instance_of(TeacherTrainingAdviser::Steps::HasTeacherId).to receive(:skipped?) { true }
      expect(subject).to be_skipped
    end

    it "returns true if has_id is false" do
      wizardstore["has_id"] = false
      expect(subject).to be_skipped
    end
  end
end
