module Degree
  class PrimaryMathsEnglishGrade4 < PrimaryMathsEnglishGrade4
    def next_step
      if has_required_subjects == "yes"
        "degree/subject_interested_teaching"
      else
        "qualification_required"
      end
    end
  end
end
