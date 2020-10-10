module TeacherTrainingAdviser::Steps
  class WhatSubjectDegree < Wizard::Step
    extend ApiOptions

    OMIT_SUBJECT_IDS = [
      "bc68e0c1-7212-e911-a974-000d3a206976", # No Preference
    ].freeze

    attribute :degree_subject, :string

    validates :degree_subject, presence: true

    def self.options
      generate_api_options(:get_teaching_subjects, OMIT_SUBJECT_IDS)
    end

    def skipped?
      returning_teacher = @store["returning_to_teaching"]
      not_studying_or_have_a_degree = [
        TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_OPTIONS[:studying],
        TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_OPTIONS[:yes],
      ].none?(@store["degree_options"])

      returning_teacher || not_studying_or_have_a_degree
    end
  end
end
