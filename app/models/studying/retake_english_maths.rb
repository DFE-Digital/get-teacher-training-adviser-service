module Studying
  class RetakeEnglishMaths < RetakeEnglishMaths
    def next_step
      if planning_to_retake_gcse_maths_and_english_id == OPTIONS[:yes]
        "studying/subject_interested_teaching"
      else
        "qualification_required"
      end
    end
  end
end
