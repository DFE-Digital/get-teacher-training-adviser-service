module Studying
  class RetakeEnglishMaths < RetakeEnglishMaths
    def next_step
      if retaking_english_maths == true
        "studying/subject_interested_teaching"
      else
        "qualification_required"
      end
    end
  end
end
