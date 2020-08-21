require "rails_helper"

RSpec.describe SignUp::Steps::ReturningTeacher do
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

  describe "#degree_options" do
    it "defaults" do
      expect(subject.degree_options).to eq(ReturningTeacher::DEGREE_OPTIONS[:returner])
    end
  end

  describe "#preferred_education_phase_id" do
    it "defaults" do
      expect(subject.preferred_education_phase_id).to eq(StageInterestedTeaching::OPTIONS[:secondary].to_i)
    end
  end
end
