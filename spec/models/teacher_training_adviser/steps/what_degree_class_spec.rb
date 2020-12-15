require "rails_helper"

RSpec.describe TeacherTrainingAdviser::Steps::WhatDegreeClass do
  include_context "wizard step"
  it_behaves_like "a wizard step"
  it_behaves_like "a wizard step that exposes API pick list items as options",
                  :get_qualification_uk_degree_grades, described_class::OMIT_GRADE_IDS

  context "attributes" do
    it { is_expected.to respond_to :uk_degree_grade_id }
  end

  describe "#uk_degree_grade_id" do
    it "allows a valid uk_degree_grade_id" do
      grade = GetIntoTeachingApiClient::PickListItem.new(id: TeacherTrainingAdviser::Steps::WhatDegreeClass.options["Not applicable"])
      allow_any_instance_of(GetIntoTeachingApiClient::PickListItemsApi).to \
        receive(:get_qualification_uk_degree_grades) { [grade] }
      expect(subject).to allow_value(grade.id).for :uk_degree_grade_id
    end

    it { is_expected.to_not allow_values("", nil, 456).for :uk_degree_grade_id }
  end

  describe "#skipped?" do
    it "returns false if WhatSubjectDegree step was shown" do
      expect_any_instance_of(TeacherTrainingAdviser::Steps::WhatSubjectDegree).to receive(:skipped?) { false }
      expect(subject).to_not be_skipped
    end

    it "returns true if WhatSubjectDegree was skipped" do
      expect_any_instance_of(TeacherTrainingAdviser::Steps::WhatSubjectDegree).to receive(:skipped?) { true }
      expect(subject).to be_skipped
    end
  end

  describe "#reviewable_answers" do
    subject { instance.reviewable_answers }
    let(:pick_list_item) { GetIntoTeachingApiClient::PickListItem.new(id: 123, value: "Value") }
    before do
      allow_any_instance_of(GetIntoTeachingApiClient::PickListItemsApi).to \
        receive(:get_qualification_uk_degree_grades) { [pick_list_item] }
      instance.uk_degree_grade_id = pick_list_item.id
    end

    it { is_expected.to eq({ "uk_degree_grade_id" => "Value" }) }
  end
end
