module Degree
  class RetakeScience < RetakeScience
    def next_step
      if planning_to_retake_cgse_science_id == OPTIONS[:yes]
        "degree/start_teacher_training"
      else
        "qualification_required"
      end
    end
  end
end
