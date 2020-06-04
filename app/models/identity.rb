class Identity < Base
  attribute :email_address, :string
  attribute :first_name, :string
  attribute :last_name, :string

  validates :email_address, format: { with: URI::MailTo::EMAIL_REGEXP, message: "You need to complete this field" }
  validates :first_name, presence: { message: "You need to complete this field" }
  validates :last_name, presence: { message: "You need to complete this field" }

  def next_step
    "returning_teacher"
  end
end