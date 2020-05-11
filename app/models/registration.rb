class Registration
  include ActiveModel::Model
  include ActiveModel::Attributes
  include MultiStepper

  attribute :email_address, :string
  attribute :first_name, :string
  attribute :last_name, :string
  attribute :returning_to_teaching, :boolean
  attribute :stage, :integer

  validates :email_address, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true

  #with_options if: :is_stage0? do |stage0|
  #  stage0.validates :email_address, presence: true
  #  stage0.validates :first_name, presence: true
  # stage0.validates :last_name, presence: true
  #end
  
  validates :returning_to_teaching, presence: true, if: -> { stage > 0 }

  def self.total_steps
    1
  end

  def total_steps
    self.class.total_steps
  end

  def is_stage0?
    self.stage == "0"
  end

end