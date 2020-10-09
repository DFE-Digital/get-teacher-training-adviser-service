module TeacherTrainingAdviser::Steps
  class OverseasTelephone < Wizard::Step
    attribute :telephone, :string

    validates :telephone, telephone: true, allow_blank: true

    before_validation if: :telephone do
      self.telephone = telephone.to_s.strip.presence
    end

    def self.contains_personal_details?
      true
    end

    def skipped?
      overseas_country_skippped = @wizard.all_skipped?(OverseasCountry.key)
      degree_options = @wizard.find(HaveADegree.key).degree_options
      equivalent_degree = degree_options == HaveADegree::DEGREE_OPTIONS[:equivalent]

      overseas_country_skippped || equivalent_degree
    end
  end
end
