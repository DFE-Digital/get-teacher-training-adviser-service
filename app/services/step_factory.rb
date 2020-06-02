class StepFactory
  # need to register permitted names/classes
  STEP_NAMES = [
    'Identity', 'ReturningTeacher', 'PrimaryOrSecondary', 'QualifiedToTeach', 'DateOfBirth', 'UkOrOverseas',
    'UkCandidate', 'UkCompletion', 'OptInEmails', 'AcceptPrivacyPolicy', 'OverseasCandidate', 'OverseasCompletion', 'HaveADegree', 'WhatSubjectDegree', 'StageInterestedTeaching', 'ScienceGrade4',
    'PrimaryMathsEnglishGrade4', 'QualificationRequired', 'SubjectInterestedTeaching', 'SecondaryMathsEnglishGrade4', 'RetakeEnglishMaths', 'StartTeacherTraining', 'EquivalentStageInterestedTeaching', 'NoDegree', 'UkNewPrimaryCompletion', 'UkNewSecondaryCompletion', 'UkStudyingCompletion', 'CompleteApplication',

    'Degree::WhatSubjectDegree', 'Degree::StageInterestedTeaching', 'Degree::ScienceGrade4',
    'Degree::PrimaryMathsEnglishGrade4', 'Degree::SubjectInterestedTeaching', 'Degree::StartTeacherTraining', 'Degree::DateOfBirth', 'Degree::UkOrOverseas', 'Degree::UkCandidate', 'Degree::UkCompletion', 'Degree::SecondaryMathsEnglishGrade4', 'Degree::RetakeEnglishMaths', 'Degree::OverseasCandidate', 'Degree::OverseasCompletion',

    'Equivalent::StageInterestedTeaching', 'Equivalent::SubjectInterestedTeaching', 'Equivalent::StartTeacherTraining', 'Equivalent::DateOfBirth', 'Equivalent::UkOrOverseas', 'Equivalent::UkCandidate', 'Equivalent::UkCompletion', 'Equivalent::OverseasCandidate', 'Equivalent::OverseasCompletion' 
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
    raise NameNotFoundError.new(classified_name) unless STEP_NAMES.include?(classified_name)
    Object.const_get(classified_name).new
  end

end