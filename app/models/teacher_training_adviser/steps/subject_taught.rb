module TeacherTrainingAdviser::Steps
  class SubjectTaught < Wizard::Step
    extend ApiOptions

    attribute :subject_taught_id, :string

    validates :subject_taught_id, types: { method: :get_teaching_subjects }

    def self.options
      generate_api_options(GetIntoTeachingApiClient::TypesApi.new.get_teaching_subjects)
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
