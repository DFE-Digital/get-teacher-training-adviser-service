class WhatDegreeClass < Base
  attribute :degree_class, :string

  validates :degree_class, inclusion: { in: ["Not applicable", "First class", "2:1", "2:2", "Third class"], message: "You must select an option" }
end
