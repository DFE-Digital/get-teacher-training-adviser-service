class Registration
  include ActiveModel::Model
  include ActiveModel::Attributes
  include MultiStepper

  attribute :email_address, :string
  attribute :first_name, :string
  attribute :last_name, :string
  attribute :returning_to_teaching, :boolean
  attribute :stage, :integer

  with_options if: -> { stage == 0 } do |stage0|
    stage0.validates :email_address, format: { with: URI::MailTo::EMAIL_REGEXP }
    stage0.validates :first_name, presence: true
    stage0.validates :last_name, presence: true
  end
  
  validates :returning_to_teaching, presence: true, if: -> { stage > 0 }

  def self.total_steps
    1
  end

  def total_steps
    self.class.total_steps
  end

end