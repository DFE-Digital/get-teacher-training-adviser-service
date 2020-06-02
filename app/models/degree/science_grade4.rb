module Degree
  class ScienceGrade4 < ScienceGrade4
    def next_step
      if have_science == "yes"
        "degree/primary_maths_english_grade4"
      else
        "qualification_required"
      end
    end
  end
end
