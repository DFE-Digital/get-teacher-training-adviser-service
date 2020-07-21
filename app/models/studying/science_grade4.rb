module Studying
  class ScienceGrade4 < ScienceGrade4
    def next_step
      if has_gcse_science_id == OPTIONS[:yes]
        "studying/subject_interested_teaching"
      else
        "studying/retake_science"
      end
    end
  end
end
