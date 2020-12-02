require "rails_helper"

RSpec.describe TeacherTrainingAdviser::Steps::StageOfDegree do
  include_context "wizard step"
  it_behaves_like "a wizard step"
  it_behaves_like "a wizard step that exposes API types as options", :get_qualification_degree_status

  context "attributes" do
    it { is_expected.to respond_to :degree_status_id }
  end

  describe "#degree_status_id" do
    it "allows a valid degree status id" do
      status = GetIntoTeachingApiClient::TypeEntity.new(id: 123)
      allow_any_instance_of(GetIntoTeachingApiClient::TypesApi).to \
        receive(:get_qualification_degree_status) { [status] }
      expect(subject).to allow_value(status.id).for :degree_status_id
    end

    it { is_expected.to_not allow_values("", nil, 456).for :degree_status_id }
  end

  describe "#skipped?" do
    it "returns false if HaveADegree step was shown and they are studying for a degree" do
      expect_any_instance_of(TeacherTrainingAdviser::Steps::HaveADegree).to receive(:skipped?) { false }
      wizardstore["degree_options"] = TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_OPTIONS[:studying]
      expect(subject).to_not be_skipped
    end

    it "returns true if HaveADegree was skipped" do
      expect_any_instance_of(TeacherTrainingAdviser::Steps::HaveADegree).to receive(:skipped?) { true }
      expect(subject).to be_skipped
    end

    it "returns true if not studying for a degree" do
      wizardstore["degree_options"] = TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_OPTIONS[:yes]
      expect(subject).to be_skipped
    end
  end

  describe "#reviewable_answers" do
    subject { instance.reviewable_answers }
    let(:type) { GetIntoTeachingApiClient::TypeEntity.new(id: 123, value: "Value") }
    before do
      allow_any_instance_of(GetIntoTeachingApiClient::TypesApi).to \
        receive(:get_qualification_degree_status) { [type] }
      instance.degree_status_id = type.id
    end

    it { is_expected.to eq({ "degree_status_id" => "Value" }) }
  end
end
