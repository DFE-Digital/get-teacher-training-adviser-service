class WhatDegreeClass < Base
  extend ApiOptions

  attribute :uk_degree_grade_id, :integer

  validates :uk_degree_grade_id, types: { method: :get_qualification_uk_degree_grades, message: "You must select an option" }

  def self.options
    generate_api_options(ApiClient.get_qualification_uk_degree_grades)
  end

  def next_step
    "degree/stage_interested_teaching"
  end
end
