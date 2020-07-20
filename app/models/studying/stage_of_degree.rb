module Studying
  class StageOfDegree < Base
    extend ApiOptions
    # overwrites session[:registration]["degree"]
    attribute :degree, :string

    validates :degree, types: { method: :get_qualification_degree_status, message: "You must select an option" }

    def self.options
      generate_api_options(ApiClient::get_qualification_degree_status)
    end

    def next_step
      "studying/what_subject_degree"
    end
  end
end
