class StartTeacherTraining < Base
  attribute :year_of_entry, :string

  validate :date_cannot_be_in_the_past
  
  def year_range(number_of_years) # sets year range for view
    (Date.today.year..Date.today.next_year(number_of_years).year).map do |year|
      OpenStruct.new(value: year, name: year)
    end
  end

  def date_cannot_be_in_the_past
    if year_of_entry.present? && year_of_entry.to_i < Date.today.year
      errors.add(:year_of_entry, "Date can't be in the past")
    end
  end

  def next_step
    "date_of_birth"
  end

end 