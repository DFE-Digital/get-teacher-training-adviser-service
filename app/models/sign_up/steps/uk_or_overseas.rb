module SignUp::Steps
  class UkOrOverseas < Wizard::Step
    attribute :uk_or_overseas, :string
    attribute :country_id, :string

    validates :uk_or_overseas, inclusion: { in: %w[UK overseas], message: "Select if you live in the UK or overseas" }
    validates :country_id, types: { method: :get_country_types }, allow_nil: true

    def uk_or_overseas=(value)
      super
      if value == "UK"
        self.country_id = ApiClient.get_country_types.find { |v| v.value = "United Kingdom" }.id
      end
    end
  end
end
