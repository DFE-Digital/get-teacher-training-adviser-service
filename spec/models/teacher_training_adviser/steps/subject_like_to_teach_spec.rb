require "rails_helper"

RSpec.describe TeacherTrainingAdviser::Steps::SubjectLikeToTeach do
  include_context "wizard step"
  let(:valid_id) { described_class::INCLUDE_SUBJECT_IDS.sample }

  it_behaves_like "a wizard step"
  it_behaves_like "a wizard step that exposes API lookup items as options",
                  :get_teaching_subjects, nil, described_class::INCLUDE_SUBJECT_IDS

  context "attributes" do
    it { is_expected.to respond_to :preferred_teaching_subject_id }
  end

  describe "#sanitized_options" do
    subject { described_class.sanitized_options }

    before { allow(described_class).to receive(:options).and_return({ "Languages (other)" => "1" }) }

    it {
      expect(subject).to eq({
        "Modern foreign language" => "1",
        "Other" => "-1",
      })
    }
  end

  describe "#preferred_teaching_subject_id" do
    it "allows a valid preferred_teaching_subject_id" do
      subject_item = GetIntoTeachingApiClient::LookupItem.new(id: valid_id)
      allow_any_instance_of(GetIntoTeachingApiClient::LookupItemsApi).to \
        receive(:get_teaching_subjects) { [subject_item] }
      expect(subject).to allow_value(subject_item.id).for :preferred_teaching_subject_id
    end

    it { is_expected.to allow_value(described_class::OTHER_SUBJECT_ID).for :preferred_teaching_subject_id }
    it { is_expected.not_to allow_values("", nil, "invalid-id").for :preferred_teaching_subject_id }
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

    let(:lookup_item) { GetIntoTeachingApiClient::LookupItem.new(id: valid_id, value: "Value") }

    before do
      allow_any_instance_of(GetIntoTeachingApiClient::LookupItemsApi).to \
        receive(:get_teaching_subjects) { [lookup_item] }
      instance.preferred_teaching_subject_id = lookup_item.id
    end

    it { is_expected.to eq({ "preferred_teaching_subject_id" => "Value" }) }
  end
end
