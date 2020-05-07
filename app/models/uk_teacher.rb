class UkTeacher
  include ActiveModel::Model
  include ActiveModel::Attributes
  include MultiStepper

  attribute :postcode, :string
  attribute :address_line_1, :string
  attribute :address_line_2, :string
  attribute :town_city, :string
  attribute :email_opt_in, :boolean
  attribute :privacy_policy, :boolean
  attribute :confirmed, :boolean
  attribute :stage, :string

  # what is the gds format?
  validates_format_of :postcode, :with => /^([A-Z]{1,2}\d[A-Z\d]? ?\d[A-Z]{2}|GIR ?0A{2})$/i, :multiline => true, if: -> { stage == "0" } 

  def self.total_steps
    4
  end

  def total_steps
    self.class.total_steps
  end 

end