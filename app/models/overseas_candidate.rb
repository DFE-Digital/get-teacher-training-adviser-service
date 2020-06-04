class OverseasCandidate < Base
  attribute :telephone_number, :string
  attribute :callback_date, :string
  attribute :callback_time, :string 

  validates :telephone_number, length: { in: 5..20, too_short: "Telephone number is too short", too_long: "Telephone number is too long (maximum is 20 characters)" }, format: { with: /\A[0-9\s]+\z/, message: "Telephone number must consist of numbers only" }
  validates :callback_date, presence: { message: "You need to complete this field" }
  validates :callback_time, presence: { message: "You need to complete this field" }

  def next_step
    "overseas_completion"
  end


end 