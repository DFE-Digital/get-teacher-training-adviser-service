module TeacherTrainingAdviser::Steps
  class StageOfDegree < Wizard::Step
    extend ApiOptions
    # overwrites session[:sign_up]["degree_status_id"]
    attribute :degree_status_id, :integer

    validates :degree_status_id, types: { method: :get_qualification_degree_status, message: "You must select an option" }

    def skipped?
      @store["degree_options"] != TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_OPTIONS[:studying]
    end

    def self.options
      generate_api_options(GetIntoTeachingApiClient::TypesApi.new.get_qualification_degree_status)
    end
  end
end
