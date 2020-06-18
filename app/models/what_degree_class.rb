class WhatDegreeClass < Base
  attribute :degree_class, :string

  validates :degree_class, types: { method: :get_qualification_types, message: "You must select 'Not applicable', 'First class', '2:1', '2:2' or 'Third class and lower class'" }
end