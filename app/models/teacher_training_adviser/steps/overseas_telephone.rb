module TeacherTrainingAdviser::Steps
  class OverseasTelephone < Wizard::Step
    attribute :address_telephone, :string

    validates :address_telephone, telephone: true, allow_blank: true

    before_validation if: :address_telephone do
      self.address_telephone = address_telephone.to_s.strip.presence
    end

    def self.contains_personal_details?
      true
    end

    def optional?
      true
    end

    def skipped?
      return true if super

      overseas_country_skippped = other_step(:overseas_country).skipped?
      degree_options = other_step(:have_a_degree).degree_options
      equivalent_degree = degree_options == HaveADegree::DEGREE_OPTIONS[:equivalent]

      overseas_country_skippped || equivalent_degree
    end
  end
end
