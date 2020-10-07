module TeacherTrainingAdviser::Steps
  class UkOrOverseas < Wizard::Step
    attribute :uk_or_overseas, :string
    attribute :country_id, :string

    UK_COUNTRY_ID = "72f5c2e6-74f9-e811-a97a-000d3a2760f2".freeze
    OPTIONS = { uk: "UK", overseas: "Overseas" }.freeze

    validates :uk_or_overseas, inclusion: { in: OPTIONS.values }
    validates :country_id, types: { method: :get_country_types }, allow_nil: true

    def reviewable_answers
      {
        "uk_or_overseas" => uk_or_overseas,
      }
    end

    def uk_or_overseas=(value)
      super
      self.country_id = UK_COUNTRY_ID if value == OPTIONS[:uk]
    end
  end
end
