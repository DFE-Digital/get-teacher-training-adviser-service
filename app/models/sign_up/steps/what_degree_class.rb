module SignUp::Steps
  class WhatDegreeClass < Wizard::Step
    extend ApiOptions

    attribute :uk_degree_grade_id, :integer

    validates :uk_degree_grade_id, types: { method: :get_qualification_uk_degree_grades, message: "You must select an option" }

    def skipped?
      ![
        HaveADegree::DEGREE_OPTIONS[:studying],
        HaveADegree::DEGREE_OPTIONS[:degree],
      ].include?(@store["degree_options"])
    end

    def self.options
      generate_api_options(ApiClient.get_qualification_uk_degree_grades)
    end
  end
end
