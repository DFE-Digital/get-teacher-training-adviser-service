module TeacherTrainingAdviser::Steps
  class SubjectLikeToTeach < Wizard::Step
    extend ApiOptions

    attribute :preferred_teaching_subject_id, :string

    OTHER_SUBJECT_ID = "-1".freeze
    INCLUDE_SUBJECT_IDS = [
      "a42655a1-2afa-e811-a981-000d3a276620", # Maths
      "ac2655a1-2afa-e811-a981-000d3a276620", # Physics
      "a22655a1-2afa-e811-a981-000d3a276620", # Languages (other)
    ].freeze

    def self.options
      generate_api_options(:get_teaching_subjects, nil, INCLUDE_SUBJECT_IDS)
    end

    def self.sanitized_options
      options.tap do |options|
        options["Modern foreign language"] = options.delete("Languages (other)")
        options["Other"] = OTHER_SUBJECT_ID
      end
    end

    validates :preferred_teaching_subject_id, inclusion: { in: sanitized_options.values }

    def skipped?
      !@wizard.find(ReturningTeacher.key).returning_to_teaching
    end

    def reviewable_answers
      super.tap do |answers|
        answers["preferred_teaching_subject_id"] = self.class.options.key(preferred_teaching_subject_id)
      end
    end
  end
end
