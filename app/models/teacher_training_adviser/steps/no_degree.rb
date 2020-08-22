module TeacherTrainingAdviser::Steps
  class NoDegree < Wizard::Step
    def can_proceed?
      false
    end

    def skipped?
      @store["degree_options"] != TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_OPTIONS[:no]
    end
  end
end
