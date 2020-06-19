module Degree
  class PrimaryRetakeEnglishMaths < PrimaryRetakeEnglishMaths
    def next_step
      if retaking_english_maths == "yes" 
        "degree/retake_science"
      else
        "qualification_required"
      end
    end
  end
end