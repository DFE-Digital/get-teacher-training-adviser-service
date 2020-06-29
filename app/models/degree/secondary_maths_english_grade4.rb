module Degree
  class SecondaryMathsEnglishGrade4 < SecondaryMathsEnglishGrade4
    def next_step
      if has_required_subjects == "yes"
        "degree/subject_interested_teaching"
      else
        "degree/retake_english_maths"
      end
    end
  end
end
