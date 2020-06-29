class WhatSubjectDegree < Base
  attribute :degree_subject, :string

  validates :degree_subject, presence: true

  def next_step
    "stage_interested_teaching"
  end
end
