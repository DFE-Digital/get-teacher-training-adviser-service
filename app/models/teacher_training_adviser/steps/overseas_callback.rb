module TeacherTrainingAdviser::Steps
  class OverseasCallback < UkCallback
    attribute :time_zone, :string

    validates :time_zone, presence: { message: "Select a time zone" }

    def reviewable_answers
      super.tap do |answers|
        answers["time_zone"] = time_zone.to_s
      end
    end

    def skipped?
      @store["returning_to_teaching"] ||
        @store["degree_options"] != TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_OPTIONS[:equivalent] ||
        @store["uk_or_overseas"] != TeacherTrainingAdviser::Steps::UkOrOverseas::OPTIONS[:overseas]
    end
  end
end
