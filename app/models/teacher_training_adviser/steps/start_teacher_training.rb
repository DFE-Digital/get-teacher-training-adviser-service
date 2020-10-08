module TeacherTrainingAdviser::Steps
  class StartTeacherTraining < Wizard::Step
    attribute :initial_teacher_training_year_id, :integer

    validates :initial_teacher_training_year_id, inclusion: { in: :year_ids }

    NUMBER_OF_YEARS = 3
    NOT_SURE_ID = 12_917

    def reviewable_answers
      super.tap do |answers|
        answers["initial_teacher_training_year_id"] = years.find { |y| y.id.to_s == initial_teacher_training_year_id.to_s }&.value
      end
    end

    def years
      years = GetIntoTeachingApiClient::TypesApi.new.get_candidate_initial_teacher_training_years
      years.select { |year| year.id.to_i == 12_917 || year.value.to_i.between?(first_year, first_year + (NUMBER_OF_YEARS - 1)) }
    end

    def year_ids
      years.map { |year| year.id.to_i }
    end

    def skipped?
      returning_teacher = @store["returning_to_teaching"]

      returning_teacher
    end

  private

    def first_year
      # After 17th September you can no longer start teacher training for that year.
      current_year = Time.zone.today.year
      include_current_year = Time.zone.today < Date.new(current_year, 9, 18)
      include_current_year ? current_year : current_year + 1
    end
  end
end
