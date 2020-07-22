module Degree
  class SecondaryMathsEnglishGrade4 < SecondaryMathsEnglishGrade4
    def next_step
      if has_gcse_maths_and_english_id == SecondaryMathsEnglishGrade4::OPTIONS[:yes]
        "degree/subject_interested_teaching"
      else
        "degree/retake_english_maths"
      end
    end
  end
end
