module Degree
  class ScienceGrade4 < ScienceGrade4
    def next_step
      if has_gcse_science_id == OPTIONS[:yes]
        "degree/start_teacher_training"
      else
        "degree/retake_science"
      end
    end
  end
end
