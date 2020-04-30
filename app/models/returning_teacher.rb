class ReturningTeacher
  include ActiveModel::Model
  include ActiveModel::Attributes
  include MultiStepper

  attribute :primary_or_secondary, :string

  def total_steps
    0
  end

end