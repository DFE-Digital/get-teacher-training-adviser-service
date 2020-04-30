class Registration
  include ActiveModel::Model
  include ActiveModel::Attributes
  include MultiStepper

  attribute :email, :string
  attribute :first_name, :string
  attribute :last_name, :string
  attribute :returning_to_teaching, :boolean

  def total_steps
    1
  end

end