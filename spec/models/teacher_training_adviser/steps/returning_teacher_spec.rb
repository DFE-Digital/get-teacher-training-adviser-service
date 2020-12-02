require "rails_helper"

RSpec.describe TeacherTrainingAdviser::Steps::ReturningTeacher do
  include_context "wizard step"
  it_behaves_like "a wizard step"

  context "attributes" do
    it { is_expected.to respond_to :returning_to_teaching }
    it { is_expected.to respond_to :degree_options }
  end

  describe "#returning_to_teaching" do
    it { is_expected.to_not allow_values("", nil).for :returning_to_teaching }
    it { is_expected.to allow_value(true, false).for :returning_to_teaching }
  end

  describe "#returning_to_teaching=" do
    it "sets degree_options if returning_to_teaching is true" do
      subject.returning_to_teaching = true
      expect(subject.degree_options).to eq(TeacherTrainingAdviser::Steps::ReturningTeacher::DEGREE_OPTIONS[:returner])
    end

    it "does not set degree_options if returning_to_teaching is false" do
      subject.returning_to_teaching = false
      expect(subject.degree_options).to be_nil
    end
  end

  describe "#reviewable_answers" do
    subject { instance.reviewable_answers }
    before { instance.returning_to_teaching = true }
    it { is_expected.to eq({ "returning_to_teaching" => "Yes" }) }
  end
end
