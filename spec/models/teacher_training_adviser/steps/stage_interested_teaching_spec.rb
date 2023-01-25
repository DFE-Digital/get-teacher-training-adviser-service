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

  describe "#skipped?" do
    it "returns false if HaveADegree step was shown and degree_options is not studying" do
      expect_any_instance_of(TeacherTrainingAdviser::Steps::HaveADegree).to receive(:skipped?).and_return(false)
      wizardstore["degree_options"] = TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_OPTIONS[:yes]
      expect(subject).not_to be_skipped
    end

    it "returns false if HaveADegree step was not shown and degree_options is studying (final year)" do
      expect_any_instance_of(TeacherTrainingAdviser::Steps::HaveADegree).to receive(:skipped?).and_return(true)
      wizardstore["degree_options"] = TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_OPTIONS[:studying]
      expect_any_instance_of(TeacherTrainingAdviser::Steps::StageOfDegree).to receive(:final_year?).and_return(true)
      expect(subject).not_to be_skipped
    end

    it "returns true if HaveADegree was shown and degree_options is studying (not final year)" do
      expect_any_instance_of(TeacherTrainingAdviser::Steps::HaveADegree).to receive(:skipped?).and_return(false)
      wizardstore["degree_options"] = TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_OPTIONS[:studying]
      expect_any_instance_of(TeacherTrainingAdviser::Steps::StageOfDegree).to receive(:final_year?).and_return(false)
      expect(subject).to be_skipped
    end
  end

  describe "#returning_teacher?" do
    before do
      allow_any_instance_of(TeacherTrainingAdviser::Steps::ReturningTeacher).to \
        receive(:returning_to_teaching) { returning_to_teaching }
    end

    context "when returning_to_teaching" do
      let(:returning_to_teaching) { true }

      it { is_expected.to be_returning_teacher }
    end

    context "when not returning_to_teaching" do
      let(:returning_to_teaching) { false }

      it { is_expected.not_to be_returning_teacher }
    end
  end

  describe "#reviewable_answers" do
    subject { instance.reviewable_answers }

    before { instance.preferred_education_phase_id = TeacherTrainingAdviser::Steps::StageInterestedTeaching::OPTIONS[:primary] }

    it { is_expected.to eq({ "preferred_education_phase_id" => "Primary" }) }
  end
end
