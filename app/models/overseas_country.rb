class OverseasCountry < Base
  extend ApiOptions

  attribute :country_code, :string

  validates :country_code, types: { method: :get_country_types }

  def self.options
    generate_api_options(ApiClient::get_country_types)
  end

  def next_step
    "overseas_telephone"
  end
end
