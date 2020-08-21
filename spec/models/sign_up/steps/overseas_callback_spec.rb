require "rails_helper"

RSpec.describe SignUp::Steps::OverseasCallback do
  include_context "wizard step"
  it_behaves_like "a wizard step"

  it { expect(described_class).to be < SignUp::Steps::UkCallback }

  context "attributes" do
    it { is_expected.to respond_to :time_zone }
  end

  context "time_zone" do
    it { is_expected.to_not allow_values("", nil).for :time_zone }
    it { is_expected.to allow_value(ActiveSupport::TimeZone.all.drop(1)).for :time_zone }
  end

  describe "#skipped?" do
    it "returns false if degree_options is equivalent and uk_or_overseas is overseas" do
      wizardstore["degree_options"] = HaveADegree::DEGREE_OPTIONS[:equivalent]
      wizardstore["uk_or_overseas"] = "overseas"
      wizardstore["returning_to_teaching"] = false
      expect(subject).to_not be_skipped
    end

    it "returns true if degree_options is not equivalent" do
      wizardstore["degree_options"] = HaveADegree::DEGREE_OPTIONS[:degree]
      wizardstore["uk_or_overseas"] = "overseas"
      wizardstore["returning_to_teaching"] = false
      expect(subject).to be_skipped
    end

    it "returns true if uk_or_overseas is not overseas" do
      wizardstore["degree_options"] = HaveADegree::DEGREE_OPTIONS[:equivalent]
      wizardstore["uk_or_overseas"] = "UK"
      wizardstore["returning_to_teaching"] = false
      expect(subject).to be_skipped
    end

    it "returns true if returning_to_teaching is true" do
      wizardstore["degree_options"] = HaveADegree::DEGREE_OPTIONS[:equivalent]
      wizardstore["uk_or_overseas"] = "UK"
      wizardstore["returning_to_teaching"] = true
      expect(subject).to be_skipped
    end
  end
end
