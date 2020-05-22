class OptInEmails < Base
  attribute :confirmed, :boolean, default: false

  validates :confirmed, inclusion: { in: [true, false] }

  def next_step
    "accept_privacy_policy"
  end
end