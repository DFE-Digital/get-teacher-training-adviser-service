class WhatSubjectDegree < Base
  attribute :degree_subject, :string
  
  validates :degree_subject, inclusion: { in: %w(Maths History English French), message: "Please select an option."}

  def next_step
    "stage_interested_in_teaching"
  end
end