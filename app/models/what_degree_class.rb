class WhatDegreeClass < Base
  attribute :degree_class, :string

  validates :degree_class, types: { method: :get_qualification_uk_degree_grades, message: "You must select an option" }

  OPTIONS = { "Not applicable": "222750000",
    "First class": "222750001",
    "2:1": "222750002",
    "2:2": "222750003",
    "Third class or below": "222750004",
    "Pass (grade unknown)": "222750005",
  }

  def next_step
    "degree/stage_interested_teaching"
  end
end
