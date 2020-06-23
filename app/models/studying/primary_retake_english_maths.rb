module Studying
  class PrimaryRetakeEnglishMaths < PrimaryRetakeEnglishMaths
    def next_step
      if retaking_english_maths == true 
        "studying/retake_science"
      else
        "qualification_required"
      end
    end
  end
end