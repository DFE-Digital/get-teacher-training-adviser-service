module TeacherTrainingAdviser::Steps
  class StartTeacherTraining < Wizard::Step
    attribute :initial_teacher_training_year_id, :integer

    validates :initial_teacher_training_year_id, inclusion: { in: :year_ids }

    NUMBER_OF_YEARS = 3
    NOT_SURE_ID = 12_917

    def reviewable_answers
      super.tap do |answers|
        answers["initial_teacher_training_year_id"] = years.find { |y| y.id == initial_teacher_training_year_id }&.value
      end
    end

    def years
      items = GetIntoTeachingApiClient::PickListItemsApi.new.get_candidate_initial_teacher_training_years

      filter_items(items).map do |item|
        item.value = formatted_value(item)
        item
      end
    end

    def year_ids
      years.map(&:id)
    end

    def skipped?
      other_step(:returning_teacher).returning_to_teaching
    end

  private

    def formatted_value(item)
      return item.value if item.id == NOT_SURE_ID

      year = item.value.to_i

      if year == current_year
        "#{year} - start your training this September"
      else
        year.to_s
      end
    end

    def filter_items(items)
      items.select do |item|
        item.id == NOT_SURE_ID ||
          item.value.to_i.between?(first_year, first_year + (NUMBER_OF_YEARS - 1))
      end
    end

    def first_year
      # After 17th September you can no longer start teacher training for that year.
      include_current_year = Time.zone.today < Date.new(current_year, 9, 18)
      include_current_year ? current_year : current_year + 1
    end

    def current_year
      Time.zone.today.year
    end
  end
end
