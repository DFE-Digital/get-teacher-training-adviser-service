class StartTeacherTraining < Base
  attribute :year_of_entry, :string

  validates :year_of_entry, types: { method: :get_candidate_initial_teacher_training_years, message: "You must select an option from the list" }
  validate :date_cannot_be_in_the_past, unless: :dont_know

  def self.options
    option_list = {}
    ApiClient::get_candidate_initial_teacher_training_years.each { |type| option_list[type.value] = type.id }
    option_list
  end

  def year_range(number_of_years) # sets year range for view, this must be within api range!
    years = ApiClient.get_candidate_initial_teacher_training_years
    years.select { |year| year.value == "Not sure" || year.value.to_i.between?(Date.today.year, Date.today.next_year(number_of_years).year) }
  end

  def date_cannot_be_in_the_past
    if year_of_entry.present? && year_of_entry.to_i < Date.today.year
      errors.add(:year_of_entry, "Date can't be in the past")
    end
  end

  def dont_know
    year_of_entry == "Not sure"
  end

  def next_step
    "date_of_birth"
  end
end
