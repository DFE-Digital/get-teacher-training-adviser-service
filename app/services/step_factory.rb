class StepFactory
  # need to register permitted names/classes
  STEP_NAMES = [
    'Identity', 'ReturningTeacher', 'PrimaryOrSecondary', 'QualifiedToTeach', 'DateOfBirth', 'UkOrOverseas',
    'UkCandidate', 'UkCompletion', 'OptInEmails', 'AcceptPrivacyPolicy', 'OverseasCandidate', 'OverseasCompletion', 'HaveADegree', 'WhatSubjectDegree'
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