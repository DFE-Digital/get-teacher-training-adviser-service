require "rails_helper"

RSpec.describe TeacherTrainingAdviser::Steps::SubjectTaught do
  include_context "wizard step"
  it_behaves_like "a wizard step"
  it_behaves_like "a wizard step that exposes API lookup items as options",
                  :get_teaching_subjects, described_class::OMIT_SUBJECT_IDS

  context "attributes" do
    it { is_expected.to respond_to :subject_taught_id }
  end

  describe "#subject_taught_id" do
    it "allows a valid subject_taught_id" do
      subject_item = GetIntoTeachingApiClient::LookupItem.new(id: "abc-123")
      allow_any_instance_of(GetIntoTeachingApiClient::LookupItemsApi).to \
        receive(:get_teaching_subjects) { [subject_item] }
      expect(subject).to allow_value(subject_item.id).for :subject_taught_id
    end

    it { is_expected.not_to allow_values("", nil, "invalid-id").for :subject_taught_id }
  end

  describe "#skipped?" do
    it "returns false if returning_to_teaching is true" do
      expect_any_instance_of(TeacherTrainingAdviser::Steps::ReturningTeacher).to receive(:returning_to_teaching).and_return(true)
      expect(subject).not_to be_skipped
    end

    it "returns true if returning_to_teaching is false" do
      expect_any_instance_of(TeacherTrainingAdviser::Steps::ReturningTeacher).to receive(:returning_to_teaching).and_return(false)
      expect(subject).to be_skipped
    end
  end

  describe "#reviewable_answers" do
    subject { instance.reviewable_answers }

    let(:lookup_item) { GetIntoTeachingApiClient::LookupItem.new(id: "123", value: "Value") }

    before do
      allow_any_instance_of(GetIntoTeachingApiClient::LookupItemsApi).to \
        receive(:get_teaching_subjects) { [lookup_item] }
      instance.subject_taught_id = lookup_item.id
    end

    it { is_expected.to eq({ "subject_taught_id" => "Value" }) }
  end
end
