module TeacherTrainingAdviser::Steps
  class WhatDegreeClass < Wizard::Step
    extend ApiOptions

    OMIT_GRADE_IDS = [
      "222750004", # Third class or below
      "222750005", # Unknown
    ].freeze

    attribute :uk_degree_grade_id, :integer

    def self.options
      generate_api_options(:get_qualification_uk_degree_grades, OMIT_GRADE_IDS)
    end

    validates :uk_degree_grade_id, inclusion: { in: options.values.map(&:to_i) }

    def skipped?
      @wizard.all_skipped?(WhatSubjectDegree.key)
    end

    def studying?
      @wizard.find(HaveADegree.key).degree_options == HaveADegree::DEGREE_OPTIONS[:studying]
    end

    def reviewable_answers
      super.tap do |answers|
        answers["uk_degree_grade_id"] = self.class.options.key(uk_degree_grade_id.to_s)
      end
    end
  end
end
