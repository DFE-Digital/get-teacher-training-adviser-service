require "rails_helper"

RSpec.describe TeacherTrainingAdviser::Steps::ReturningTeacher do
  include_context "wizard step"
  it_behaves_like "a wizard step"

  context "attributes" do
    it { is_expected.to respond_to :returning_to_teaching }
    it { is_expected.to respond_to :degree_options }
    it { is_expected.to respond_to :preferred_education_phase_id }
  end

  describe "#returning_to_teaching" do
    it { is_expected.to_not allow_values("", nil).for :returning_to_teaching }
    it { is_expected.to allow_value(true, false).for :returning_to_teaching }
  end

  describe "#returning_to_teaching=" do
    it "sets degree_options and preferred_education_phase_id if returning_to_teaching is true" do
      subject.returning_to_teaching = true
      expect(subject.degree_options).to eq(TeacherTrainingAdviser::Steps::ReturningTeacher::DEGREE_OPTIONS[:returner])
      expect(subject.preferred_education_phase_id).to eq(TeacherTrainingAdviser::Steps::StageInterestedTeaching::OPTIONS[:secondary])
    end

    it "does not set degree_options or preferred_education_phase_id if returning_to_teaching is false" do
      subject.returning_to_teaching = false
      expect(subject.degree_options).to be_nil
      expect(subject.preferred_education_phase_id).to be_nil
    end
  end
end
