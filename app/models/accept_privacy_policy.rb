class AcceptPrivacyPolicy < Base
  attribute :confirmed, :boolean, default: false

  validates :confirmed, inclusion: { in: [true] , message: "You must accept the privacy policy in order to talk to a teaching adviser"}

  def next_step
    return "complete_application" if confirmed
    nil
  end
end