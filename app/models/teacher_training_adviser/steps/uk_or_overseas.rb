module TeacherTrainingAdviser::Steps
  class UkOrOverseas < Wizard::Step
    attribute :uk_or_overseas, :string
    attribute :country_id, :string

    OPTIONS = { uk: "UK", overseas: "Overseas" }.freeze

    validates :uk_or_overseas, inclusion: { in: OPTIONS.values, message: "Select if you live in the UK or overseas" }
    validates :country_id, types: { method: :get_country_types }, allow_nil: true

    def reviewable_answers
      {
        "uk_or_overseas" => uk_or_overseas,
      }
    end

    def uk_or_overseas=(value)
      super
      if value == OPTIONS[:uk]
        self.country_id = GetIntoTeachingApiClient::TypesApi.new.get_country_types.find { |v| v.value = "United Kingdom" }.id
      end
    end
  end
end
