class DateOfBirth < Base
  attribute :date_of_birth, :datetime
  attribute "date_of_birth(3i)", :string
  attribute "date_of_birth(2i)", :string
  attribute "date_of_birth(1i)", :string

  before_validation :make_a_date

  validates :date_of_birth, presence: { message: "You need to enter your date of birth" }
  validate :date_cannot_be_in_the_future, :age_limit, :upper_age_limit

  def date_cannot_be_in_the_future
    if date_of_birth.present? && date_of_birth > Date.today
      errors.add(:date_of_birth, "Date can't be in the future")
    end
  end

  def age_limit
    if date_of_birth.present? && date_of_birth > Date.today.years_ago(18)
      errors.add(:date_of_birth, "You must be 18 years or older to use this service")
    end
  end

  def upper_age_limit
    if date_of_birth.present? && date_of_birth < Date.today.years_ago(70)
      errors.add(:date_of_birth, "You must be less than 70 years old")
    end
  end

  def make_a_date
    year = send("date_of_birth(1i)").to_i
    month = send("date_of_birth(2i)").to_i
    day = send("date_of_birth(3i)").to_i

    begin # catch invalid dates, e.g. 31 Feb
      self.date_of_birth = DateTime.new(year, month, day)
    rescue ArgumentError
      nil
    end
  end

  def next_step
    "uk_or_overseas"
  end
end
