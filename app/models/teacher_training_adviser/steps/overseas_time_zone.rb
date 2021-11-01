module TeacherTrainingAdviser::Steps
  class OverseasTimeZone < DFEWizard::Step
    attribute :address_telephone, :string
    attribute :time_zone, :string

    validates :address_telephone, telephone: { international: true }, presence: true
    validates :time_zone, presence: true

    before_validation if: :address_telephone do
      self.address_telephone = address_telephone.to_s.strip.presence
    end

    def self.contains_personal_details?
      true
    end

    def filtered_time_zones
      ActiveSupport::TimeZone.all.drop(1)
    end

    def reviewable_answers
      { "address_telephone" => address_telephone }.tap do |answers|
        answers["time_zone"] = time_zone if time_zone.present?
      end
    end

    def address_telephone_value
      address_telephone || other_step(:overseas_country).dial_in_code
    end

    def skipped?
      overseas_country_skipped = other_step(:overseas_country).skipped?
      degree_options = other_step(:have_a_degree).degree_options
      equivalent_degree = degree_options == HaveADegree::DEGREE_OPTIONS[:equivalent]

      overseas_country_skipped || !equivalent_degree
    end
  end
end
