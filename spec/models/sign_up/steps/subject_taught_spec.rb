require "rails_helper"

RSpec.describe SignUp::Steps::SubjectTaught do
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

    it { is_expected.to_not allow_value("").for :subject_taught_id }
    it { is_expected.to_not allow_value(nil).for :subject_taught_id }
  end
end
