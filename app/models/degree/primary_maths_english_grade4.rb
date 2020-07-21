module Degree
  class PrimaryMathsEnglishGrade4 < PrimaryMathsEnglishGrade4
    def next_step
      if has_gcse_maths_and_english_id == OPTIONS[:yes]
        "degree/science_grade4"
      else
        "degree/primary_retake_english_maths"
      end
    end
  end
end
