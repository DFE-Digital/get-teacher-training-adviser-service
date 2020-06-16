class UkTelephone < Base
  attribute :telephone_number, :string
  
  validates :telephone_number, length: { maximum: 20, too_long: "Telephone number is too long (maximum is 20 characters)" }, format: { with: /\A[0-9\s]+\z/, message: "Telephone number must consist of numbers only" },
  allow_blank: true

  def next_step
    "uk_completion"
  end

end