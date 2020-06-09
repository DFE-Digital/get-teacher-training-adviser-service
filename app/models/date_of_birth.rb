class DateOfBirth < Base

  attribute :date_of_birth, :date
  attribute "date_of_birth(3i)", :string
  attribute "date_of_birth(2i)", :string
  attribute "date_of_birth(1i)", :string

  before_validation :make_a_date
  
  validates :date_of_birth, presence: { message: "You need to enter your date of birth" }
  validate :date_cannot_be_in_the_future, :age_limit

  def date_cannot_be_in_the_future
    if self.date_of_birth.present? && date_of_birth > Date.today
      errors.add(:date_of_birth, "Date can't be in the future")
    end
  end

  def age_limit
    if date_of_birth.present? && date_of_birth.year < 1950
      errors.add(:date_of_birth, "You must be less than 70 years old")
    end
  end

  def make_a_date
    year = self.send("date_of_birth(1i)").to_i 
    month = self.send("date_of_birth(2i)").to_i
    day = self.send("date_of_birth(3i)").to_i
    
    begin # catch invalid dates, e.g. 31 Feb
      self.date_of_birth = Date.new(year, month, day)
    rescue ArgumentError
      return
    end

  end

  def next_step
   "uk_or_overseas" 
  end

end 


