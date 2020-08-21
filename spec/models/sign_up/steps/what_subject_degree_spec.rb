require "rails_helper"

RSpec.describe SignUp::Steps::WhatSubjectDegree do
  include_context "wizard step"
  it_behaves_like "a wizard step"

  context "attributes" do
    it { is_expected.to respond_to :degree_subject }
  end

  describe "#degree_subject" do
    it "allows a valid degree_subject" do
      subject_type = GetIntoTeachingApiClient::TypeEntity.new(id: "abc-123")
      allow_any_instance_of(GetIntoTeachingApiClient::TypesApi).to \
        receive(:get_teaching_subjects) { [subject_type] }
      expect(subject).to allow_value(subject_type.id).for :degree_subject
    end

    it { is_expected.to_not allow_value("").for :degree_subject }
    it { is_expected.to_not allow_value(nil).for :degree_subject }
  end

  describe "#self.options" do
    it "is a pending example"
  end
end
