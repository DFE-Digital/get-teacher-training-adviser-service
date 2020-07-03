class OverseasCountry < Base
  attribute :country_code, :string

  validates :country_code, types: { method: :get_country_types }

  def next_step
    "overseas_telephone"
  end
end
