class StepFactory
  # need to register permitted names/classes
  STEP_NAMES = [
    "Identity",
    "ReturningTeacher",
    "PreviousId",
    "HasTeacherId",
    "PreviousSubject",
    "SubjectLikeToTeach",
    "DateOfBirth",
    "UkOrOverseas",
    "UkCandidate",
    "UkTelephone",
    "UkCompletion",
    "AcceptPrivacyPolicy",
    "OverseasCountry",
    "OverseasTelephone",
    "OverseasCompletion",
    "NoDegree",
    "HaveADegree",
    "QualificationRequired",
    "CompleteApplication",

    "Degree::WhatSubjectDegree",
    "Degree::WhatDegreeClass",
    "Degree::StageInterestedTeaching",
    "Degree::ScienceGrade4",
    "Degree::PrimaryMathsEnglishGrade4",
    "Degree::SubjectInterestedTeaching",
    "Degree::StartTeacherTraining",
    "Degree::DateOfBirth",
    "Degree::UkOrOverseas",
    "Degree::UkCandidate",
    "Degree::UkCompletion",
    "Degree::SecondaryMathsEnglishGrade4",
    "Degree::RetakeEnglishMaths",
    "Degree::OverseasTelephone",
    "Degree::OverseasCompletion",
    "Degree::UkTelephone",
    "Degree::PrimaryRetakeEnglishMaths",
    "Degree::RetakeScience",
    "Degree::OverseasCountry",

    "Studying::StageOfDegree",
    "Studying::WhatSubjectDegree",
    "Studying::StageInterestedTeaching",
    "Studying::ScienceGrade4",
    "Studying::PrimaryMathsEnglishGrade4",
    "Studying::SubjectInterestedTeaching",
    "Studying::StartTeacherTraining",
    "Studying::DateOfBirth",
    "Studying::UkOrOverseas",
    "Studying::UkCandidate",
    "Studying::UkCompletion",
    "Studying::SecondaryMathsEnglishGrade4",
    "Studying::RetakeEnglishMaths",
    "Studying::OverseasTelephone",
    "Studying::OverseasCompletion",
    "Studying::WhatDegreeClass",
    "Studying::UkTelephone",
    "Studying::PrimaryRetakeEnglishMaths",
    "Studying::RetakeScience",
    "Studying::OverseasCountry",

    "Equivalent::StageInterestedTeaching",
    "Equivalent::SubjectInterestedTeaching",
    "Equivalent::StartTeacherTraining",
    "Equivalent::DateOfBirth",
    "Equivalent::UkOrOverseas",
    "Equivalent::UkCandidate",
    "Equivalent::UkCompletion",
    "Equivalent::OverseasCandidate",
    "Equivalent::OverseasCompletion",
    "Equivalent::UkCallback",
    "Equivalent::OverseasCountry",
  ].freeze

  class NameNotFoundError < StandardError
    attr_reader :name
    def initialize(name)
      super
      @name = name
    end

    def message
      "Step name not found for #{name}"
    end
  end

  def self.create(name)
    classified_name = name.camelize
    # need to redirect to root or last valid step.
    raise NameNotFoundError, classified_name unless STEP_NAMES.include?(classified_name)

    Object.const_get(classified_name).new
  end
end
