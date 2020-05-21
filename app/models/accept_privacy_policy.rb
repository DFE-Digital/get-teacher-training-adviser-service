class AcceptPrivacyPolicy < Base
  attribute :confirmed, :boolean, default: false

  validates :confirmed, inclusion: { in: [true] , message: "Please accept the privacy policy to complete your aplication"}

  def next_step
    return "complete_registration" if confirmed
    nil
  end
end