module TeacherTrainingAdviser::Steps
  class UkTelephone < Wizard::Step
    attribute :telephone, :string

    validates :telephone, telephone: true, allow_blank: true

    before_validation if: :telephone do
      self.telephone = telephone.to_s.strip.presence
    end

    def self.contains_personal_details?
      true
    end

    def skipped?
      uk_address_skipped = other_step(:uk_address).skipped?
      degree_options = other_step(:have_a_degree).degree_options
      equivalent_degree = degree_options == HaveADegree::DEGREE_OPTIONS[:equivalent]

      uk_address_skipped || equivalent_degree
    end
  end
end
