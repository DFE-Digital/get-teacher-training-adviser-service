require "rails_helper"

RSpec.describe SignUp::Steps::UkCallback do
  include_context "wizard step"
  it_behaves_like "a wizard step"

  context "attributes" do
    it { is_expected.to respond_to :phone_call_scheduled_at }
    it { is_expected.to respond_to :telephone }
  end

  context "phone_call_scheduled_at" do
    it { is_expected.to_not allow_values("", nil, "invalid_date").for :phone_call_scheduled_at }
    it { is_expected.to allow_value(Time.zone.now).for :phone_call_scheduled_at }
  end

  context "telephone" do
    it { is_expected.to_not allow_values("", "12345uh", "123-123-123").for :telephone }
    it { is_expected.to allow_values("123456", "123456 90").for :telephone }
  end

  describe "#skipped?" do
    it "returns false if degree_options is equivalent and uk_or_overseas is UK" do
      wizardstore["degree_options"] = HaveADegree::DEGREE_OPTIONS[:equivalent]
      wizardstore["uk_or_overseas"] = "UK"
      expect(subject).to_not be_skipped
    end

    it "returns true if degree_options is not equivalent" do
      wizardstore["degree_options"] = HaveADegree::DEGREE_OPTIONS[:degree]
      wizardstore["uk_or_overseas"] = "UK"
      expect(subject).to be_skipped
    end

    it "returns true if uk_or_overseas is not UK" do
      wizardstore["degree_options"] = HaveADegree::DEGREE_OPTIONS[:equivalent]
      wizardstore["uk_or_overseas"] = "overseas"
      expect(subject).to be_skipped
    end
  end

  describe "#self.options" do
    it "is a pending example"
  end
end
