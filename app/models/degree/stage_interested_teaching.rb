module Degree
  class StageInterestedTeaching < StageInterestedTeaching
    def next_step
      if preferred_education_phase_id == OPTIONS[:secondary]
        "degree/secondary_maths_english_grade4"
      else
        "degree/primary_maths_english_grade4"
      end
    end
  end
end
