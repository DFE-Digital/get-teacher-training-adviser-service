FactoryBot.define do
  factory :accept_privacy_policy do
    accepted_policy_id { ApiClient.get_latest_privacy_policy.id }
  end
end
