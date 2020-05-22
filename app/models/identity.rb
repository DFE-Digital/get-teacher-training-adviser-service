class Identity < Base
  attribute :email_address, :string
  attribute :first_name, :string
  attribute :last_name, :string

  validates :email_address, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :first_name, presence: true
  validates :last_name, presence: true

  def next_step
    "returning_teacher"
  end
end