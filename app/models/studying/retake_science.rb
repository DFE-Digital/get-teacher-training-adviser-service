module Studying
  class RetakeScience < RetakeScience
    def next_step
      if retaking_science == true
        "studying/start_teacher_training"
      else
        "qualification_required"
      end
    end
  end
end
