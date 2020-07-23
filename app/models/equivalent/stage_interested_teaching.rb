module Equivalent
  class Equivalent::StageInterestedTeaching < StageInterestedTeaching
    def next_step
      if preferred_education_phase_id == StageInterestedTeaching::OPTIONS[:primary]
        "equivalent/start_teacher_training"
      else
        "equivalent/subject_interested_teaching"
      end
    end
  end
end
