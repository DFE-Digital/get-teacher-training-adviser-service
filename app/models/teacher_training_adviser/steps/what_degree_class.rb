module TeacherTrainingAdviser::Steps
  class WhatDegreeClass < Wizard::Step
    extend ApiOptions

    attribute :uk_degree_grade_id, :integer

    def self.options
      result = generate_api_options(GetIntoTeachingApiClient::TypesApi.new.get_qualification_uk_degree_grades)
      # remove third class and grade unknown from options
      result.reject { |_k, v| %w[222750004 222750005].include? v }
    end

    validates :uk_degree_grade_id, inclusion: { in: TeacherTrainingAdviser::Steps::WhatDegreeClass.options.map { |_k, v| v.to_i }, message: "Select an option from the list" }

    def skipped?
      returning_teacher = @store["returning_to_teaching"]
      not_studying_or_have_a_degree = [
        TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_OPTIONS[:studying],
        TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_OPTIONS[:degree],
      ].none?(@store["degree_options"])

      returning_teacher || not_studying_or_have_a_degree
    end

    def studying?
      @store["degree_options"] == TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_OPTIONS[:studying]
    end

    def reviewable_answers
      super.tap do |answers|
        answers["uk_degree_grade_id"] = self.class.options.key(uk_degree_grade_id)
      end
    end
  end
end
