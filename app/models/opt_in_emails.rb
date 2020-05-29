class OptInEmails < Base
  attribute :email, :string

  validates :email, inclusion: { in: %w(yes no), message: "Please answer yes or no."}

  def next_step
    "accept_privacy_policy"
  end
end