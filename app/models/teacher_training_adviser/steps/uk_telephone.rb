module TeacherTrainingAdviser::Steps
  class UkTelephone < Wizard::Step
    attribute :telephone, :string

    validates :telephone, telephone: true, allow_blank: true

    def skipped?
      equivalent_degree = @store["degree_options"] == "equivalent"
      overseas = @store["uk_or_overseas"] == TeacherTrainingAdviser::Steps::UkOrOverseas::OPTIONS[:overseas]

      equivalent_degree || overseas
    end
  end
end
