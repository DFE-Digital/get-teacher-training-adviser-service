module SignUp::Steps
  class OverseasCountry < Wizard::Step
    extend ApiOptions
    # overwrites UK default
    attribute :country_id, :string

    validates :country_id, types: { method: :get_country_types }

    def self.options
      generate_api_options(ApiClient.get_country_types)
    end

    def skipped?
      @store["uk_or_overseas"] == "UK"
    end
  end
end
