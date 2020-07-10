module Studying
  class PrimaryRetakeEnglishMaths < PrimaryRetakeEnglishMaths
    def next_step
      if retaking_english_maths == OPTIONS[:yes]
        "studying/science_grade4"
      else
        "qualification_required"
      end
    end
  end
end
