require "rails_helper"

RSpec.describe SignUp::Steps::WhatDegreeClass do
  include_context "wizard step"
  it_behaves_like "a wizard step"

  context "attributes" do
    it { is_expected.to respond_to :uk_degree_grade_id }
  end

  describe "#uk_degree_grade_id" do
    it "allows a valid uk_degree_grade_id" do
      grade = GetIntoTeachingApiClient::TypeEntity.new(id: 123)
      allow_any_instance_of(GetIntoTeachingApiClient::TypesApi).to \
        receive(:get_qualification_uk_degree_grades) { [grade] }
      expect(subject).to allow_value(grade.id).for :uk_degree_grade_id
    end

    it { is_expected.to_not allow_value("").for :uk_degree_grade_id }
    it { is_expected.to_not allow_value(nil).for :uk_degree_grade_id }
  end

  describe "#self.options" do
    it "is a pending example"
  end
end
