class PrimaryTeacher
  include ActiveModel::Model
  include ActiveModel::Attributes
  include MultiStepper

  attribute :qualified_subject, :string
  attribute :dob_day, :integer #date?
  attribute :dob_month, :integer
  attribute :dob_year, :integer
  attribute :uk_or_overseas, :string
  attribute :stage, :string

  
  #validates :email_address, presence: true, if: -> { stage == "0" }

  def self.total_steps
    2
  end

  def total_steps
    self.class.total_steps
  end

  

end