class UkCandidate < Base
  attribute :address_line_1, :string
  attribute :address_line_2, :string
  attribute :town_city, :string
  attribute :postcode, :string

  validates :address_line_1, presence: { message: "Enter the first line of your address" }
  validates :address_line_2, presence: { message: "Enter the second line of your address" }
  validates :town_city, presence: { message: "Enter your town or city" }
  validates_format_of :postcode, with: /^([A-Z]{1,2}\d[A-Z\d]? ?\d[A-Z]{2}|GIR ?0A{2})$/i, multiline: true, message: "Enter a real postcode"

  def next_step
    "uk_telephone"
  end
end
