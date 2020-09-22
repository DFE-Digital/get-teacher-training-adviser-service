module TeacherTrainingAdviser::Steps
  class SubjectTaught < Wizard::Step
    extend ApiOptions

    NO_PREFERENCE_ID = "bc68e0c1-7212-e911-a974-000d3a206976".freeze

    attribute :subject_taught_id, :string

    validates :subject_taught_id, types: { method: :get_teaching_subjects }

    def self.options
      generate_api_options(GetIntoTeachingApiClient::TypesApi.new.get_teaching_subjects).reject do |_, value|
        value == NO_PREFERENCE_ID
      end
    end

    def skipped?
      returning_teacher = @store["returning_to_teaching"]

      !returning_teacher
    end

    def reviewable_answers
      super.tap do |answers|
        answers["subject_taught_id"] = self.class.options.key(subject_taught_id)
      end
    end
  end
end
