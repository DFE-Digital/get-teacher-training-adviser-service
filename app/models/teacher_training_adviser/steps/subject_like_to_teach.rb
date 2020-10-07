module TeacherTrainingAdviser::Steps
  class SubjectLikeToTeach < Wizard::Step
    extend ApiOptions

    attribute :preferred_teaching_subject_id, :string

    validates :preferred_teaching_subject_id, types: { method: :get_teaching_subjects }

    def self.options
      generate_api_options(:get_teaching_subjects)
    end

    def skipped?
      returning_teacher = @store["returning_to_teaching"]

      !returning_teacher
    end

    def reviewable_answers
      super.tap do |answers|
        answers["preferred_teaching_subject_id"] = self.class.options.key(preferred_teaching_subject_id)
      end
    end
  end
end
