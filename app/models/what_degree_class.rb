class WhatDegreeClass < Base
  extend ApiOptions

  attribute :uk_degree_grade_id, :integer

  OPTIONS = { "Not applicable" => 222_750_000, "First class" => 222_750_001, "2:1" => 222_750_002, "2:2" => 222_750_003 }.freeze

  validates :uk_degree_grade_id, inclusion: { in: OPTIONS.map { |_k, v| v }, message: "Select an option from the list" }

  def self.options
    generate_api_options(ApiClient.get_qualification_uk_degree_grades)
  end

  def next_step
    "degree/stage_interested_teaching"
  end
end
