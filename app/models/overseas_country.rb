class OverseasCountry < Base
  extend ApiOptions

  attribute :country_id, :string

  validates :country_id, types: { method: :get_country_types }

  def self.options
    generate_api_options(ApiClient::get_country_types)
  end

  def next_step
    "overseas_telephone"
  end
end
