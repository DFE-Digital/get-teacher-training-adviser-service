require "get_into_teaching_api_client"

class ApiClient
  class << self
    def get_teaching_subjects
      api_instance = GetIntoTeachingApiClient::TypesApi.new
      api_instance.get_teaching_subjects
    end

    def get_candidate_initial_teacher_training_years
      api_instance = GetIntoTeachingApiClient::TypesApi.new
      api_instance.get_candidate_initial_teacher_training_years
    end

    #def get_candidate_locations
    #  api_instance = GetIntoTeachingApiClient::TypesApi.new
    #  api_instance.get_candidate_locations
    #end

    def get_candidate_preferred_education_phases
      api_instance = GetIntoTeachingApiClient::TypesApi.new
      api_instance.get_candidate_preferred_education_phases
    end

    def get_qualification_degree_status
      api_instance = GetIntoTeachingApiClient::TypesApi.new
      api_instance.get_qualification_degree_status
    end

    def get_qualification_uk_degree_grades
      api_instance = GetIntoTeachingApiClient::TypesApi.new
      api_instance.get_qualification_uk_degree_grades
    end

    def get_qualification_types
      api_instance = GetIntoTeachingApiClient::TypesApi.new
      api_instance.get_qualification_types
    end

    def get_country_types
      api_instance = GetIntoTeachingApiClient::TypesApi.new
      api_instance.get_country_types
    end
  end
end
