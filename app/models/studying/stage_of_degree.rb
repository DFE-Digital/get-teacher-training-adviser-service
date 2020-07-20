module Studying
  class StageOfDegree < Base
    extend ApiOptions
    # overwrites session[:registration]["degree"]
    attribute :degree, :string

    validates :degree, types: { method: :get_qualification_degree_status, message: "You must select an option" }

    def self.options
      generate_api_options(ApiClient::get_qualification_degree_status)
    end

    #  final_year: "222750001"
    #  second_year: "222750002"
    #  first_year: "222750003"
    #  other: "222750005"

    def next_step
      "studying/what_subject_degree"
    end
  end
end
