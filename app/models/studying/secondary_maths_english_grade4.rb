module Studying
  class SecondaryMathsEnglishGrade4 < SecondaryMathsEnglishGrade4
    def next_step
      if has_required_subjects == "yes"
        "studying/subject_interested_teaching"
      else
        "studying/retake_english_maths"
      end
    end
  end
end
