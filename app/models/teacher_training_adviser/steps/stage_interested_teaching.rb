module TeacherTrainingAdviser::Steps
  class StageInterestedTeaching < GITWizard::Step
    extend ApiOptions

    attribute :preferred_education_phase_id, :integer

    validates :preferred_education_phase_id, pick_list_items: { method: :get_candidate_preferred_education_phases }

    OPTIONS = { primary: 222_750_000, secondary: 222_750_001 }.freeze

    def reviewable_answers
      super.tap do |answers|
        answers["preferred_education_phase_id"] = OPTIONS.key(preferred_education_phase_id).to_s.capitalize
      end
    end

    def skipped?
      have_a_degree_step = other_step(:have_a_degree)
      have_a_degree_shown = !have_a_degree_step.skipped?
      studying = have_a_degree_step.degree_options == HaveADegree::DEGREE_OPTIONS[:studying]

      have_a_degree_shown && studying
    end

    def returning_teacher?
      other_step(:returning_teacher).returning_to_teaching
    end
  end
end
