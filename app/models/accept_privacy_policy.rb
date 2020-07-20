class AcceptPrivacyPolicy < Base
  attribute :accepted, :boolean, default: false

  validates :accepted, inclusion: { in: [true], message: "You must accept the privacy policy in order to talk to a teacher training adviser" }
# test api privacy policy when availible
  def next_step
    return "complete_application" if accepted

    nil
  end
end
