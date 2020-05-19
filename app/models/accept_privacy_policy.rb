class AcceptPrivacyPolicy < Base
  attribute :confirmed, :boolean, default: false

  validates :confirmed, inclusion: { in: [true, false] }

  def next_step
    if confirmed == true
      "complete_registration"
    else
      "incomplete_registration"
    end
  end
end