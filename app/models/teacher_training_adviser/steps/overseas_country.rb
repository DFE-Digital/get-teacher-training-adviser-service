module TeacherTrainingAdviser::Steps
  class OverseasCountry < Wizard::Step
    extend ApiOptions
    # overwrites UK default
    attribute :country_id, :string

    validates :country_id, types: { method: :get_country_types }

    OMIT_COUNTRY_IDS = [
      "76f5c2e6-74f9-e811-a97a-000d3a2760f2", # Unknown
      "72f5c2e6-74f9-e811-a97a-000d3a2760f2", # United Kingdom
    ].freeze

    def self.options
      generate_api_options(:get_country_types, OMIT_COUNTRY_IDS)
    end

    def skipped?
      other_step(:uk_or_overseas).uk_or_overseas == UkOrOverseas::OPTIONS[:uk]
    end

    def reviewable_answers
      super.tap do |answers|
        answers["country_id"] = self.class.options.key(country_id)
      end
    end
  end
end
