module TeacherTrainingAdviser::Steps
  class NoDegree < Wizard::Step
    def can_proceed?
      false
    end

    def skipped?
      other_step(:have_a_degree).degree_options != HaveADegree::DEGREE_OPTIONS[:no]
    end
  end
end
