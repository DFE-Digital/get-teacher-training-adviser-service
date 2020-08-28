module TeacherTrainingAdviser::Steps
  class WhatDegreeClass < Wizard::Step
    extend ApiOptions

    attribute :uk_degree_grade_id, :integer

    OPTIONS = {"Not applicable"=>222750000, "First class"=>222750001, "2:1"=>222750002, "2:2"=>222750003}

    validates :uk_degree_grade_id,  inclusion: { in: OPTIONS.map { |_k, v| v }, message: "Select an option from the list" }

    def skipped?
      @store["returning_to_teaching"] ||
        [
          TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_OPTIONS[:studying],
          TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_OPTIONS[:degree],
        ].none?(@store["degree_options"])
    end

    def studying?
      @store["degree_options"] == TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_OPTIONS[:studying]
    end

    def self.options
      generate_api_options(GetIntoTeachingApiClient::TypesApi.new.get_qualification_uk_degree_grades)
    end
  end
end
