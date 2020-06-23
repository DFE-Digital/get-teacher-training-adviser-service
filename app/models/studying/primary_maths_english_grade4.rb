module Studying
  class PrimaryMathsEnglishGrade4 < PrimaryMathsEnglishGrade4
    def next_step
      if has_required_subjects == true 
        "studying/science_grade4"
      else
        "studying/primary_retake_english_maths"
      end
    end
  end
end
