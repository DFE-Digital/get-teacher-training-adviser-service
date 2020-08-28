module TeacherTrainingAdviser::Steps
  class ReviewAnswers < Wizard::Step
    def personal_detail_answers_by_step
      answers_by_step.select { |k| k.contains_personal_details? } # rubocop:disable Style/SymbolProc
    end

    def other_answers_by_step
      answers_by_step.reject { |k| k.contains_personal_details? } # rubocop:disable Style/SymbolProc
    end

  private

    def answers_by_step
      @answers_by_step ||= @wizard.reviewable_answers_by_step
    end
  end
end
