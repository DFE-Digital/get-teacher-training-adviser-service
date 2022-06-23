require "rails_helper"

RSpec.describe TeacherTrainingAdviser::Steps::UkOrOverseas do
  include_context "with a wizard step"
  it_behaves_like "a wizard step"

  describe "attributes" do
    it { is_expected.to respond_to :uk_or_overseas }
  end

  describe "#uk_or_overseas" do
    it { is_expected.not_to allow_value("").for :uk_or_overseas }
    it { is_expected.not_to allow_value(nil).for :uk_or_overseas }
    it { is_expected.not_to allow_value("Denmark").for :uk_or_overseas }
    it { is_expected.to allow_values(*TeacherTrainingAdviser::Steps::UkOrOverseas::OPTIONS.values).for :uk_or_overseas }
  end

  describe "#reviewable_answers" do
    subject { instance.reviewable_answers }

    before { instance.uk_or_overseas = TeacherTrainingAdviser::Steps::UkOrOverseas::OPTIONS[:overseas] }

    it { is_expected.to eq({ "uk_or_overseas" => "Overseas" }) }
  end
end
