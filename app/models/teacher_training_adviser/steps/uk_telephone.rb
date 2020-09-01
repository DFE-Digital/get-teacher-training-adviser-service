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
      equivalent_degree = @store["degree_options"] == "equivalent"
      overseas = @store["uk_or_overseas"] == TeacherTrainingAdviser::Steps::UkOrOverseas::OPTIONS[:overseas]

      equivalent_degree || overseas
    end
  end
end
