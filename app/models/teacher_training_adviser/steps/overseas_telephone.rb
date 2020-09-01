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
      equivalent_degree = @store["degree_options"] == "equivalent"
      in_uk = @store["uk_or_overseas"] == TeacherTrainingAdviser::Steps::UkOrOverseas::OPTIONS[:uk]

      equivalent_degree || in_uk
    end
  end
end
