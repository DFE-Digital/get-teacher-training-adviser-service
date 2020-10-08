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
    it "returns false if degree_options is studying/degree" do
      wizardstore["degree_options"] = TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_OPTIONS[:studying]
      expect(subject).to_not be_skipped
      wizardstore["degree_options"] = TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_OPTIONS[:yes]
      expect(subject).to_not be_skipped
    end

    it "returns true if degree_options is not studying/degree" do
      wizardstore["degree_options"] = TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_OPTIONS[:equivalent]
      expect(subject).to be_skipped
    end

    it "returns true if returning_to_teaching is true" do
      wizardstore["returning_to_teaching"] = true
      expect(subject).to be_skipped
    end
  end

  describe "#reviewable_answers" do
    subject { instance.reviewable_answers }
    before { instance.has_gcse_maths_and_english_id = Crm::OPTIONS[:yes] }
    it { is_expected.to eq({ "has_gcse_maths_and_english_id" => "Yes" }) }
  end
end
