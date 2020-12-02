require "rails_helper"

RSpec.describe TeacherTrainingAdviser::Steps::GcseMathsEnglish do
  include_context "wizard step"
  it_behaves_like "a wizard step"

  context "attributes" do
    it { is_expected.to respond_to :has_gcse_maths_and_english_id }
  end

  describe "has_gcse_maths_and_english_id" do
    it { is_expected.to_not allow_values(nil, 123).for :has_gcse_maths_and_english_id }
    it { is_expected.to allow_values(*TeacherTrainingAdviser::Steps::GcseMathsEnglish::OPTIONS.values).for :has_gcse_maths_and_english_id }
  end

  describe "#skipped?" do
    it "returns false if WhatSubjectDegree step was shown" do
      expect_any_instance_of(TeacherTrainingAdviser::Steps::WhatSubjectDegree).to receive(:skipped?) { false }
      expect(subject).to_not be_skipped
    end

    it "returns true if WhatSubjectDegree step was skipped" do
      expect_any_instance_of(TeacherTrainingAdviser::Steps::WhatSubjectDegree).to receive(:skipped?) { true }
      expect(subject).to be_skipped
    end
  end

  describe "#reviewable_answers" do
    subject { instance.reviewable_answers }
    before { instance.has_gcse_maths_and_english_id = Crm::OPTIONS[:yes] }
    it { is_expected.to eq({ "has_gcse_maths_and_english_id" => "Yes" }) }
  end
end
