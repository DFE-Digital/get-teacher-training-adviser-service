class OverseasCountry < Base
  attribute :country_code, :string

  validates :country_code, length: { is: 2 }

  def next_step
    "overseas_candidate"
  end
end