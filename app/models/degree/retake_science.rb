module Degree
  class RetakeScience < RetakeScience
    def next_step
      if retaking_science == OPTIONS[:yes]
        "degree/start_teacher_training"
      else
        "qualification_required"
      end
    end
  end
end
