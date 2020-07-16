module Studying
  class RetakeScience < RetakeScience
    def next_step
      if retaking_science == OPTIONS[:yes]
        "studying/subject_interested_teaching"
      else
        "qualification_required"
      end
    end
  end
end
