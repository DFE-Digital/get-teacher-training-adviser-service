module TeacherTrainingAdviser::Steps
  class SubjectInterestedTeaching < Wizard::Step
    extend ApiOptions

    attribute :preferred_teaching_subject_id, :string

    validates :preferred_teaching_subject_id, types: { method: :get_teaching_subjects, message: "Please select a subject" }

    IGNORED_SUBJECT_IDS = [
      "bc2655a1-2afa-e811-a981-000d3a276620", # Other
      "bc68e0c1-7212-e911-a974-000d3a206976", # No Preference
    ].freeze

    def self.options
      generate_api_options(GetIntoTeachingApiClient::TypesApi.new.get_teaching_subjects).reject do |_, id|
        IGNORED_SUBJECT_IDS.include?(id)
      end
    end

    def reviewable_answers
      super.tap do |answers|
        answers["preferred_teaching_subject_id"] = self.class.options.key(preferred_teaching_subject_id)
      end
    end

    def skipped?
      returning_teacher = @store["returning_to_teaching"]
      phase_is_not_secondary = @store["preferred_education_phase_id"] != TeacherTrainingAdviser::Steps::StageInterestedTeaching::OPTIONS[:secondary]

      returning_teacher || phase_is_not_secondary
    end
  end
end
