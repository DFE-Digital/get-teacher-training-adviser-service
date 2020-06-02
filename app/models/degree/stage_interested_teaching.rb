module Degree
  class StageInterestedTeaching < StageInterestedTeaching 
    def next_step
      if primary_or_secondary == "primary"
        "degree/science_grade4"
      else
        "degree/secondary_maths_english_grade4" 
      end
    end
  end
end
