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
    it "returns false if degree_options is studying" do
      wizardstore["degree_options"] = TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_OPTIONS[:studying]
      expect(subject).to_not be_skipped
    end

    it "returns true if degree_options is not studying" do
      wizardstore["degree_options"] = TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_OPTIONS[:degree]
      expect(subject).to be_skipped
    end
  end
end
