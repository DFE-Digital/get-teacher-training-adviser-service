module TeacherTrainingAdviser::Steps
  class SubjectLikeToTeach < DFEWizard::Step
    extend ApiOptions

    attribute :preferred_teaching_subject_id, :string

    OTHER_SUBJECT_ID = "-1".freeze
    INCLUDE_SUBJECT_IDS = [
      "842655a1-2afa-e811-a981-000d3a276620", # Chemistry
      "8a2655a1-2afa-e811-a981-000d3a276620", # Computing
      "a42655a1-2afa-e811-a981-000d3a276620", # Maths
      "a22655a1-2afa-e811-a981-000d3a276620", # Languages (other)
      "ac2655a1-2afa-e811-a981-000d3a276620", # Physics
    ].freeze

    def self.options
      generate_api_options(GetIntoTeachingApiClient::LookupItemsApi, :get_teaching_subjects, nil, INCLUDE_SUBJECT_IDS)
    end

    def self.sanitized_options
      sorted_options = options.tap do |opts|
        opts["Modern foreign language"] = opts.delete("Languages (other)")
      end.sort
      sorted_options << ["Other", OTHER_SUBJECT_ID]
    end

    validates :preferred_teaching_subject_id, inclusion: { in: sanitized_options.map(&:last) }

    def skipped?
      !other_step(:returning_teacher).returning_to_teaching
    end

    def reviewable_answers
      super.tap do |answers|
        answers["preferred_teaching_subject_id"] = self.class.options.key(preferred_teaching_subject_id)
      end
    end
  end
end
