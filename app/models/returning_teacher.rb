class ReturningTeacher
  include ActiveModel::Model
  include ActiveModel::Attributes
  include MultiStepper

  attribute :primary_or_secondary, :string
  attribute :stage, :string

  def self.total_steps
    0
  end

  def total_steps
    self.class.total_steps
  end 

end