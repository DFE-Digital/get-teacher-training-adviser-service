class AcceptPrivacyPolicy < Base
  attribute :confirmed, :boolean, default: false

  validates :confirmed, inclusion: { in: [true] , message: "You must accept the privacy policy to complete your application"}

  def next_step
    return "complete_application" if confirmed
    nil
  end
end