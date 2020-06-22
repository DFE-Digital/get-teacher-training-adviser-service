module Degree
  class ScienceGrade4 < ScienceGrade4
    def next_step
      if have_science == "yes"
        "degree/start_teacher_training"
      else
        "degree/retake_science"
      end
    end
  end
end
