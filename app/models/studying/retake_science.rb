module Studying
  class RetakeScience < RetakeScience
    def next_step
      if planning_to_retake_gcse_science_id == OPTIONS[:yes]
        "studying/start_teacher_training"
      else
        "qualification_required"
      end
    end
  end
end
