module TeacherTrainingAdviser::Steps
  class SubjectInterestedTeaching < Wizard::Step
    extend ApiOptions

    attribute :preferred_teaching_subject_id, :string

    validates :preferred_teaching_subject_id, types: { method: :get_teaching_subjects, message: "Please select a subject" }

    def self.options
      generate_api_options(GetIntoTeachingApiClient::TypesApi.new.get_teaching_subjects)
    end

    def reviewable_answers
      super.tap do |answers|
        answers["preferred_teaching_subject_id"] = self.class.options.key(preferred_teaching_subject_id)
      end
    end

    def skipped?
      @store["returning_to_teaching"] ||
        @store["preferred_education_phase_id"] != TeacherTrainingAdviser::Steps::StageInterestedTeaching::OPTIONS[:secondary]
    end
  end
end
