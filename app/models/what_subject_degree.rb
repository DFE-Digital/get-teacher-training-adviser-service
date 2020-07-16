class WhatSubjectDegree < Base
  attribute :degree_subject, :string

  validates :degree_subject, types: { method: :get_teaching_subjects }

  def next_step
    "stage_interested_teaching"
  end
end
