require "rails_helper"

RSpec.describe SignUp::Steps::StageInterestedTeaching do
  include_context "wizard step"
  it_behaves_like "a wizard step"

  context "attributes" do
    it { is_expected.to respond_to :preferred_education_phase_id }
  end

  describe "#preferred_education_phase_id" do
    it { is_expected.to_not allow_value("").for :preferred_education_phase_id }
    it { is_expected.to_not allow_value(nil).for :preferred_education_phase_id }
    it { is_expected.to allow_value(*StageInterestedTeaching::OPTIONS.values).for :preferred_education_phase_id }
  end

  describe "#self.options" do
    it "is a pending example"
  end
end
