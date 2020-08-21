require "rails_helper"

RSpec.describe SignUp::Steps::PreviousTeacherId do
  include_context "wizard step"
  it_behaves_like "a wizard step"

  context "attributes" do
    it { is_expected.to respond_to :teacher_id }
  end

  describe "#skipped?" do
    it "returns false if returning_to_teaching is true" do
      wizardstore["returning_to_teaching"] = true
      expect(subject).to_not be_skipped
    end

    it "returns true if returning_to_teaching is false" do
      wizardstore["uk_or_overseas"] = false
      expect(subject).to be_skipped
    end
  end
end
