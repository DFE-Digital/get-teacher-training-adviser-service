require "rails_helper"

RSpec.describe TeacherTrainingAdviser::Steps::HaveADegree do
  include_context "wizard step"
  it_behaves_like "a wizard step"

  context "attributes" do
    it { is_expected.to respond_to :degree_options }
    it { is_expected.to respond_to :degree_status_id }
    it { is_expected.to respond_to :degree_type_id }
  end

  describe "degree_options" do
    it { is_expected.to_not allow_values("random", "", nil).for :degree_options }
    it { is_expected.to allow_values(*TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_OPTIONS.values).for :degree_options }
  end

  describe "degree_status_id" do
    context "when degree_options is set" do
      before { subject.degree_options = TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_OPTIONS[:degree] }

      it { is_expected.to_not allow_values(1234, nil).for :degree_status_id }
      it { is_expected.to allow_values(*TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_STATUS_OPTIONS.values).for :degree_status_id }
    end

    context "when degree_options is not set" do
      it { is_expected.to allow_values(1234, nil).for :degree_status_id }
    end
  end

  describe "degree_type_id" do
    context "when degree_options is set" do
      before { subject.degree_options = TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_OPTIONS[:degree] }

      it { is_expected.to_not allow_values(1234, nil).for :degree_type_id }
      it { is_expected.to allow_values(*TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_TYPE.values).for :degree_type_id }
    end

    context "when degree_options is not set" do
      it { is_expected.to allow_values(1234, nil).for :degree_type_id }
    end
  end

  describe "#degree_option=" do
    it "sets the correct degree_status_id/degree_type_id for value of degree" do
      subject.degree_options = TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_OPTIONS[:degree]
      expect(subject.degree_status_id).to eq(TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_STATUS_OPTIONS[:yes])
      expect(subject.degree_type_id).to eq(TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_TYPE[:degree])
    end

    it "sets the correct degree_status_id/degree_type_id when no" do
      subject.degree_options = TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_OPTIONS[:no]
      expect(subject.degree_status_id).to eq(TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_STATUS_OPTIONS[:no])
      expect(subject.degree_type_id).to eq(TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_TYPE[:degree])
    end

    it "sets the correct degree_status_id/degree_type_id when studying" do
      subject.degree_options = TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_OPTIONS[:studying]
      expect(subject.degree_status_id).to eq(TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_STATUS_OPTIONS[:studying])
      expect(subject.degree_type_id).to eq(TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_TYPE[:degree])
    end

    it "sets the correct degree_status_id/degree_type_id when equivalent" do
      subject.degree_options = TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_OPTIONS[:equivalent]
      expect(subject.degree_status_id).to eq(TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_STATUS_OPTIONS[:yes])
      expect(subject.degree_type_id).to eq(TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_TYPE[:equivalent])
    end
  end

  describe "#skipped?" do
    it "returns false if returning_to_teaching is false" do
      wizardstore["returning_to_teaching"] = false
      expect(subject).to_not be_skipped
    end

    it "returns true if returning_to_teaching is true" do
      wizardstore["returning_to_teaching"] = true
      expect(subject).to be_skipped
    end
  end

  describe "#reviewable_answers" do
    subject { instance.reviewable_answers }
    before { instance.degree_options = TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_OPTIONS[:studying] }
    it { is_expected.to eq({ "degree_options" => "I'm studying for a degree" }) }

    context "when degree_options is nil" do
      before { instance.degree_options = nil }
      it { is_expected.to eq({ "degree_options" => nil }) }
    end
  end
end