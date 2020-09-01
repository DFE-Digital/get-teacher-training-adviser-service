require "rails_helper"

RSpec.describe TeacherTrainingAdviser::Steps::OverseasCallback do
  include_context "wizard step"
  it_behaves_like "a wizard step"

  it { expect(described_class).to be TeacherTrainingAdviser::Steps::OverseasCallback }

  context "attributes" do
    it { is_expected.to respond_to :phone_call_scheduled_at }
  end

  describe "#skipped?" do
    it "returns false if degree_options is equivalent and uk_or_overseas is overseas" do
      wizardstore["degree_options"] = TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_OPTIONS[:equivalent]
      wizardstore["uk_or_overseas"] = TeacherTrainingAdviser::Steps::UkOrOverseas::OPTIONS[:overseas]
      wizardstore["returning_to_teaching"] = false
      expect(subject).to_not be_skipped
    end

    it "returns true if degree_options is not equivalent" do
      wizardstore["degree_options"] = TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_OPTIONS[:degree]
      wizardstore["uk_or_overseas"] = TeacherTrainingAdviser::Steps::UkOrOverseas::OPTIONS[:overseas]
      wizardstore["returning_to_teaching"] = false
      expect(subject).to be_skipped
    end

    it "returns true if uk_or_overseas is not overseas" do
      wizardstore["degree_options"] = TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_OPTIONS[:equivalent]
      wizardstore["uk_or_overseas"] = TeacherTrainingAdviser::Steps::UkOrOverseas::OPTIONS[:uk]
      wizardstore["returning_to_teaching"] = false
      expect(subject).to be_skipped
    end

    it "returns true if returning_to_teaching is true" do
      wizardstore["degree_options"] = TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_OPTIONS[:equivalent]
      wizardstore["uk_or_overseas"] = TeacherTrainingAdviser::Steps::UkOrOverseas::OPTIONS[:uk]
      wizardstore["returning_to_teaching"] = true
      expect(subject).to be_skipped
    end
  end

  describe "#reviewable_answers" do
    let(:date_time) { DateTime.new(2022, 1, 1, 10, 30) }
    subject { instance.reviewable_answers }
    before do
      instance.phone_call_scheduled_at = date_time
    end
    it {
      is_expected.to eq({
        "callback_date" => date_time.to_date,
        "callback_time" => date_time.to_time, # rubocop:disable Rails/Date
      })
    }
  end
end
