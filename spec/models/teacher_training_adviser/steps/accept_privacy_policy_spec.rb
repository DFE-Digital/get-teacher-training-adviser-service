require "rails_helper"

RSpec.describe TeacherTrainingAdviser::Steps::AcceptPrivacyPolicy do
  include_context "wizard step"
  it_behaves_like "a wizard step"

  it { is_expected.to respond_to :accepted_policy_id }

  context "accepted_policy_id" do
    it { is_expected.to allow_value("0a203956-e935-ea11-a813-000d3a44a8e9").for :accepted_policy_id }
    it { is_expected.not_to allow_value("invalid-id").for :accepted_policy_id }
  end

  describe "#reviewable_answers" do
    subject { instance.reviewable_answers }

    before { instance.accepted_policy_id = "abc-123" }

    it { is_expected.to eq({}) }
  end
end
