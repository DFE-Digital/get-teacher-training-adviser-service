module Studying
  class SecondaryMathsEnglishGrade4 < SecondaryMathsEnglishGrade4
    def next_step
      if has_gcse_maths_and_english_id == OPTIONS[:yes]
        "studying/subject_interested_teaching"
      else
        "studying/retake_english_maths"
      end
    end
  end
end
