class UkCandidate < Base
  attribute :address_line_1, :string
  attribute :address_line_2, :string
  attribute :town_city, :string
  attribute :postcode, :string

  validates :address_line_1, presence: { message: "You need to complete this field" }
  validates :address_line_2, presence: { message: "You need to complete this field" }
  validates :town_city, presence: { message: "You need to complete this field" }
  validates_format_of :postcode, :with => /^([A-Z]{1,2}\d[A-Z\d]? ?\d[A-Z]{2}|GIR ?0A{2})$/i, :multiline => true, message: "Your postcode is not recognized"


  def next_step
    "uk_completion"
  end


end 