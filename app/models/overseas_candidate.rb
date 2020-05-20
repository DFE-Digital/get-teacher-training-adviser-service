class OverseasCandidate < Base
  attribute :telephone_number, :string
  attribute :callback_date, :string
  attribute :callback_time, :string 

  validates :telephone_number, length: { minimum: 5 }, format: { with: /\A[0-9\s]+\z/ }
  validates :callback_date, presence: true
  validates :callback_time, presence: true

  def next_step
    "overseas_completion"
  end


end 