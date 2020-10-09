require "rails_helper"

RSpec.describe TeacherTrainingAdviser::Steps::UkOrOverseas do
  include_context "wizard step"
  it_behaves_like "a wizard step"

  context "attributes" do
    it { is_expected.to respond_to :uk_or_overseas }
    it { is_expected.to respond_to :country_id }
  end

  describe "#uk_or_overseas" do
    it { is_expected.to_not allow_value("").for :uk_or_overseas }
    it { is_expected.to_not allow_value(nil).for :uk_or_overseas }
    it { is_expected.to_not allow_value("Denmark").for :uk_or_overseas }
    it { is_expected.to allow_values(*TeacherTrainingAdviser::Steps::UkOrOverseas::OPTIONS.values).for :uk_or_overseas }
  end

  describe "#uk_or_overseas=" do
    it "sets country_id when UK" do
      subject.uk_or_overseas = TeacherTrainingAdviser::Steps::UkOrOverseas::OPTIONS[:uk]
      expect(subject.country_id).to eq(TeacherTrainingAdviser::Steps::UkOrOverseas::UK_COUNTRY_ID)
    end

    it "does nothing when overseas" do
      subject.uk_or_overseas = TeacherTrainingAdviser::Steps::UkOrOverseas::OPTIONS[:overseas]
      expect(subject.country_id).to be_nil
    end
  end

  describe "#reviewable_answers" do
    subject { instance.reviewable_answers }
    before { instance.uk_or_overseas = TeacherTrainingAdviser::Steps::UkOrOverseas::OPTIONS[:overseas] }
    it { is_expected.to eq({ "uk_or_overseas" => "Overseas" }) }
  end
end
