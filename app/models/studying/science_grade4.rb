module Studying
  class ScienceGrade4 < ScienceGrade4
    def next_step
      if have_science == OPTIONS[:yes]
        "studying/subject_interested_teaching"
      else
        "studying/retake_science"
      end
    end
  end
end
