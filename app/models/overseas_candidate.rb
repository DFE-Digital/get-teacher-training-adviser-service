class OverseasCandidate < Base

  attribute :telephone_number, :string
  attribute :callback_date, :date
  attribute "callback_date(3i)", :string
  attribute "callback_date(2i)", :string
  attribute "callback_date(1i)", :string
  attribute :callback_time, :string 

  before_validation :make_a_date

  validates :telephone_number, length: { in: 5..20, too_short: "Telephone number is too short", too_long: "Telephone number is too long (maximum is 20 characters)" }, format: { with: /\A[0-9\s]+\z/, message: "Telephone number must consist of numbers only" }
  validates :callback_date, presence: { message: "You need to enter a valid date" }
  validates :callback_time, presence: { message: "You need to complete this field" }

  validate :callback_date_cannot_be_in_past

  def callback_date_cannot_be_in_past
    if callback_date.present? && callback_date < Date.today
      errors.add(:callback_date, "Date can't be in the past")
    end
  end

  def make_a_date
    year = self.send("callback_date(1i)").to_i 
    month = self.send("callback_date(2i)").to_i
    day = self.send("callback_date(3i)").to_i
  
    return if year < Date.today.year || year > Date.today.next_year(10).year
    
    begin # catch invalid dates, e.g. 31 Feb
      self.callback_date = Date.new(year, month, day)
    rescue ArgumentError
      return
    end

  end

  def next_step
    "overseas_completion"
  end


end 