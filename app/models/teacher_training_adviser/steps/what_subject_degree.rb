module TeacherTrainingAdviser::Steps
  class WhatSubjectDegree < Wizard::Step
    extend ApiOptions

    attribute :degree_subject, :string

    validates :degree_subject, presence: true

    def self.options
      generate_api_options(:get_teaching_subjects)
    end

    def skipped?
      returning_teacher = @store["returning_to_teaching"]
      not_studying_or_have_a_degree = [
        TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_OPTIONS[:studying],
        TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_OPTIONS[:degree],
      ].none?(@store["degree_options"])

      returning_teacher || not_studying_or_have_a_degree
    end
  end
end
