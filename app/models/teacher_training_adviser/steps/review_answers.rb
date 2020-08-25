module TeacherTrainingAdviser::Steps
  class ReviewAnswers < Wizard::Step
    PERSONAL_DETAILS_STEPS = [
      TeacherTrainingAdviser::Steps::Identity,
      TeacherTrainingAdviser::Steps::DateOfBirth,
      TeacherTrainingAdviser::Steps::UkAddress,
      TeacherTrainingAdviser::Steps::UkTelephone,
      TeacherTrainingAdviser::Steps::OverseasTelephone,
    ].freeze

    def personal_detail_answers_by_step
      answers_by_step.select { |k| PERSONAL_DETAILS_STEPS.include?(k) }
    end

    def other_answers_by_step
      answers_by_step.reject { |k| PERSONAL_DETAILS_STEPS.include?(k) }
    end

  private

    def answers_by_step
      @answers_by_step ||= @wizard.reviewable_answers_by_step
    end
  end
end
