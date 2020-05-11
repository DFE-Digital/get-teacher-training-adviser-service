class Registration
  include ActiveModel::Model
  include ActiveModel::Attributes
  include MultiStepper

  attribute :email_address, :string
  attribute :first_name, :string
  attribute :last_name, :string
  attribute :returning_to_teaching, :boolean
  attribute :stage, :integer

  validates :email_address, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :first_name, presence: true
  validates :last_name, presence: true
  
  validates :returning_to_teaching, presence: true, if: -> { stage > 0 }

  def self.total_steps
    1
  end

  def total_steps
    self.class.total_steps
  end

end