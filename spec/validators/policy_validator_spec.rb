require "rails_helper"

RSpec.describe PolicyValidator, type: :validator do
  subject { build :accept_privacy_policy }

  it "passes when accepted_policy_id exists" do
    expect(subject).to be_valid
  end

  it "raises invalid error when accepted_policy_id not returned by Api" do
    subject.accepted_policy_id = "invalid_id"
    expect(subject).to be_invalid
  end
end
