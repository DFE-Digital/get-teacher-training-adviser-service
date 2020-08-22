module TeacherTrainingAdviser::Steps
  class StartTeacherTraining < Wizard::Step
    extend ApiOptions

    attribute :initial_teacher_training_year_id, :integer

    validates :initial_teacher_training_year_id, types: { method: :get_candidate_initial_teacher_training_years, message: "You must select an option from the list" }
    validate :date_cannot_be_in_the_past, unless: :dont_know

    def self.options
      generate_api_options(GetIntoTeachingApiClient::TypesApi.new.get_candidate_initial_teacher_training_years)
    end

    # sets year range for view, this must be within api range!
    def year_range(number_of_years)
      years = GetIntoTeachingApiClient::TypesApi.new.get_candidate_initial_teacher_training_years
      years.select { |year| year.id.to_i == 12_917 || year.value.to_i.between?(Time.zone.today.year, Time.zone.today.next_year(number_of_years).year) }
    end

    def date_cannot_be_in_the_past
      if initial_teacher_training_year_id.present? && initial_teacher_training_year_id.to_i < Time.zone.today.year
        errors.add(:initial_teacher_training_year_id, "Date can't be in the past")
      end
    end

    def dont_know
      initial_teacher_training_year_id == StartTeacherTraining.options["Not sure"].to_i
    end

    def skipped?
      @store["returning_to_teaching"]
    end
  end
end
