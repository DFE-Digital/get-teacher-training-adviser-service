module Studying
  class RetakeScience < RetakeScience
    def next_step
      if planning_to_retake_gcse_science_id == OPTIONS[:yes]
        "studying/subject_interested_teaching"
      else
        "qualification_required"
      end
    end
  end
end
