class WhatDegreeClass < Base
  extend ApiOptions

  attribute :uk_degree_grade_id, :integer

  OPTIONS = {"Not applicable"=>222750000, "First class"=>222750001, "2:1"=>222750002, "2:2"=>222750003}

  validates :uk_degree_grade_id,  inclusion: { in: OPTIONS.map { |_k, v| v }, message: "Select an option from the list" }

  def self.options
    generate_api_options(ApiClient.get_qualification_uk_degree_grades)
  end

  def next_step
    "degree/stage_interested_teaching"
  end
end
