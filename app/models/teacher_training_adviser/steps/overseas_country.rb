module TeacherTrainingAdviser::Steps
  class OverseasCountry < Wizard::Step
    extend ApiOptions
    # overwrites UK default
    attribute :country_id, :string

    validates :country_id, types: { method: :get_country_types }

    def self.options
      generate_api_options(GetIntoTeachingApiClient::TypesApi.new.get_country_types)
    end

    def skipped?
      in_uk = @store["uk_or_overseas"] == TeacherTrainingAdviser::Steps::UkOrOverseas::OPTIONS[:uk]

      in_uk
    end
  end
end
