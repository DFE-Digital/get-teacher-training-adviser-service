class OptInEmails < Base
  attribute :email, :string

  validates :email, inclusion: { in: %w(yes no), message: "You must select an option"}

  def next_step
    "accept_privacy_policy"
  end
end