require "rails_helper"

RSpec.describe PolicyValidator, :vcr, type: :validator do
  subject { build :accept_privacy_policy }

  it "is valid when accepted_policy_id exists" do
    expect(subject).to be_valid
  end

  it "is invalid when not present" do
    subject.accepted_policy_id = ""
    expect(subject).to be_invalid
  end

  it "is invalid when accepted_policy_id not returned by Api" do
    subject.accepted_policy_id = "hello"
    expect(subject).to be_invalid
  end
end
