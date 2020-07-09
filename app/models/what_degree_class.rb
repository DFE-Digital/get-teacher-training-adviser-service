class WhatDegreeClass < Base
  attribute :degree_class, :string

  validates :degree_class, types: { method: :get_qualification_uk_degree_grades, message: "You must select an option" }

  def self.options
    option_list = {}
    ApiClient::get_qualification_uk_degree_grades.each { |type| option_list[type.value] = type.id }
    option_list
  end

  def next_step
    "degree/stage_interested_teaching"
  end
end
