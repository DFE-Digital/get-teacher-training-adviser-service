class WhatDegreeClass < Base
  attribute :degree_class, :string

  validates :degree_class, types: { method: :get_qualification_uk_degree_grades, message: "You must select an option" }

  def next_step
    "degree/stage_interested_teaching"
  end
end
