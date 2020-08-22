require "rails_helper"

RSpec.describe TeacherTrainingAdviser::Steps::SubjectTaught do
  include_context "wizard step"
  it_behaves_like "a wizard step"

  context "attributes" do
    it { is_expected.to respond_to :subject_taught_id }
  end

  describe "#subject_taught_id" do
    it "allows a valid subject_taught_id" do
      subject_type = GetIntoTeachingApiClient::TypeEntity.new(id: "abc-123")
      allow_any_instance_of(GetIntoTeachingApiClient::TypesApi).to \
        receive(:get_teaching_subjects) { [subject_type] }
      expect(subject).to allow_value(subject_type.id).for :subject_taught_id
    end

    it { is_expected.to_not allow_values("", nil).for :subject_taught_id }
  end

  describe "#skipped?" do
    it "returns false if returning_to_teaching is true" do
      wizardstore["returning_to_teaching"] = true
      expect(subject).to_not be_skipped
    end

    it "returns true if returning_to_teaching is false" do
      wizardstore["returning_to_teaching"] = false
      expect(subject).to be_skipped
    end
  end
end
