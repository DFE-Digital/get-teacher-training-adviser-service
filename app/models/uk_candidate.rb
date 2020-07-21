class UkCandidate < Base
  attribute :address_line_1, :string
  attribute :address_line_2, :string
  attribute :address_city, :string
  attribute :address_postcode, :string

  validates :address_line_1, presence: { message: "Enter the first line of your address" }
  validates :address_city, presence: { message: "Enter your town or city" }
  validates_format_of :address_postcode, with: /^([A-Z]{1,2}\d[A-Z\d]? ?\d[A-Z]{2}|GIR ?0A{2})$/i, multiline: true, message: "Enter a real address_postcode"

  def next_step
    "uk_telephone"
  end
end
