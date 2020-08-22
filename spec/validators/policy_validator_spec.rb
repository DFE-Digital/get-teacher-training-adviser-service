require "rails_helper"

class PolicyValidatable
  include ActiveModel::Model

  attr_accessor :policy_id

  validates :policy_id, policy: { method: :get_privacy_policy }
end

RSpec.describe PolicyValidator, type: :validator do
  subject { PolicyValidatable.new }

  it "is valid when matches a policy" do
    policy = GetIntoTeachingApiClient::PrivacyPolicy.new(id: "abc-123")

    expect_any_instance_of(GetIntoTeachingApiClient::PrivacyPoliciesApi).to \
      receive(:get_privacy_policy).with(policy.id).and_return(policy)

    subject.policy_id = policy.id
    expect(subject).to be_valid
  end

  it "is invalid when does not match a policy" do
    expect_any_instance_of(GetIntoTeachingApiClient::PrivacyPoliciesApi).to \
      receive(:get_privacy_policy).with("def-678").and_raise(GetIntoTeachingApiClient::ApiError)

    subject.policy_id = "def-678"
    expect(subject).to be_invalid
  end
end
