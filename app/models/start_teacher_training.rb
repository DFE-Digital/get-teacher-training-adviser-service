class StartTeacherTraining < Base
  attribute :year_of_entry, :string

  validates :year_of_entry, inclusion: { in: %w(2020 2021 2022) }
  
  def year_range(number_of_years) # sets year range for view
    years = []
    (Date.today.year..Date.today.next_year(number_of_years).year).to_a.each do |year|
      years << OpenStruct.new(value: year, name: year)
    end
    years
  end

  def next_step
    "date_of_birth"
  end

end 