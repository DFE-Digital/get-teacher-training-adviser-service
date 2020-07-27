class AcceptPrivacyPolicy < Base
  attribute :accepted_policy_id, :string

  validates :accepted_policy_id, policy: { method: :get_latest_privacy_policy, message: "You must accept the privacy policy in order to talk to a teacher training adviser" }

  # test api privacy policy when availible
  def next_step
    return "complete_application" if self.valid?

    nil
  end
end
