module Degree
  class RetakeEnglishMaths < RetakeEnglishMaths
    def next_step
      if retaking == "yes"
        "degree/subject_interested_teaching"
      else
        "qualification_required"
      end
    end
  end 
end