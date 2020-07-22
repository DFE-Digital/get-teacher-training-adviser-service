module Studying
  class StageInterestedTeaching < StageInterestedTeaching
    def next_step
      if preferred_education_phase_id == OPTIONS[:secondary]
        "studying/secondary_maths_english_grade4"
      else
        "studying/primary_maths_english_grade4"
      end
    end
  end
end
