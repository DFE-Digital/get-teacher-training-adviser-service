module TeacherTrainingAdviser::Steps
  class WhatSubjectDegree < Wizard::Step
    attribute :degree_subject, :string

    validates :degree_subject, presence: true

    def skipped?
      [
        TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_OPTIONS[:studying],
        TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_OPTIONS[:degree],
      ].none?(@store["degree_options"])
    end
  end
end
