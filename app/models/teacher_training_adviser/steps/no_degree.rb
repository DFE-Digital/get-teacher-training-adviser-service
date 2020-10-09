module TeacherTrainingAdviser::Steps
  class NoDegree < Wizard::Step
    def can_proceed?
      false
    end

    def skipped?
      @wizard.find(HaveADegree.key).degree_options != HaveADegree::DEGREE_OPTIONS[:no]
    end
  end
end
