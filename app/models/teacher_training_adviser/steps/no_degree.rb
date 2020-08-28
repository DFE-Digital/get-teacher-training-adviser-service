module TeacherTrainingAdviser::Steps
  class NoDegree < Wizard::Step
    def can_proceed?
      false
    end

    def skipped?
      has_degree = @store["degree_options"] != TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_OPTIONS[:no]

      has_degree
    end
  end
end
