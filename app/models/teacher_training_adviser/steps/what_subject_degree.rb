module TeacherTrainingAdviser::Steps
  class WhatSubjectDegree < Wizard::Step
    attribute :degree_subject, :string

    validates :degree_subject, presence: true

    def skipped?
      [
        HaveADegree::DEGREE_OPTIONS[:studying],
        HaveADegree::DEGREE_OPTIONS[:degree],
      ].none?(@store["degree_options"])
    end
  end
end
