require "rails_helper"

RSpec.describe TeacherTrainingAdviser::Steps::StageInterestedTeaching do
  include_context "with a wizard step"
  it_behaves_like "a wizard step"

  it { is_expected.not_to be_skipped }

  describe "attributes" do
    it { is_expected.to respond_to :preferred_education_phase_id }
  end

  describe "#preferred_education_phase_id" do
    it { is_expected.not_to allow_values("", nil, 123).for :preferred_education_phase_id }
    it { is_expected.to allow_value(*TeacherTrainingAdviser::Steps::StageInterestedTeaching::OPTIONS.values).for :preferred_education_phase_id }
  end

  describe "#reviewable_answers" do
    subject { instance.reviewable_answers }

    before { instance.preferred_education_phase_id = TeacherTrainingAdviser::Steps::StageInterestedTeaching::OPTIONS[:primary] }

    it { is_expected.to eq({ "preferred_education_phase_id" => "Primary" }) }
  end
end
