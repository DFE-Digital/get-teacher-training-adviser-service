require "rails_helper"

RSpec.describe SignUp::Steps::RetakeGcseScience do
  include_context "wizard step"
  it_behaves_like "a wizard step"

  context "attributes" do
    it { is_expected.to respond_to :planning_to_retake_gcse_science_id }
  end

  describe "planning_to_retake_gcse_science_id" do
    it { is_expected.to_not allow_value(nil).for :planning_to_retake_gcse_science_id }
    it { is_expected.to allow_values(Crm::OPTIONS[:yes], Crm::OPTIONS[:no]).for :planning_to_retake_gcse_science_id }
  end

  describe "#skipped?" do
    it "returns false if has_gcse_science_id is no" do
      wizardstore["has_gcse_science_id"] = Crm::OPTIONS[:no]
      expect(subject).to_not be_skipped
    end

    it "returns true if has_gcse_science_id is not not no" do
      wizardstore["has_gcse_science_id"] = nil
      expect(subject).to be_skipped
      wizardstore["has_gcse_science_id"] = Crm::OPTIONS[:yes]
      expect(subject).to be_skipped
    end
  end
end
