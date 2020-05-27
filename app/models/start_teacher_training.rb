class StartTeacherTraining < Base
  attribute :year_of_entry, :string

  validates :year_of_entry, inclusion: { in: %w(2020 2021 2022) }

  def next_step
    "date_of_birth"
  end

end 