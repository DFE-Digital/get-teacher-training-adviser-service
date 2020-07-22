class AcceptPrivacyPolicy < Base
  attribute :accepted_policy_id, :boolean, default: false

  validates :accepted_policy_id, inclusion: { in: [true], message: "You must accept the privacy policy in order to talk to a teacher training adviser" }
# test api privacy policy when availible
  def next_step
    return "complete_application" if accepted_policy_id

    nil
  end
end
