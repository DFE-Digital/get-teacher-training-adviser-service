module TeacherTrainingAdviser::Steps
  class OverseasTelephone < Wizard::Step
    attribute :telephone, :string

    validates :telephone, telephone: true, allow_blank: true

    def skipped?
      equivalent_degree = @store["degree_options"] == "equivalent"
      in_uk = @store["uk_or_overseas"] == TeacherTrainingAdviser::Steps::UkOrOverseas::OPTIONS[:uk]

      equivalent_degree || in_uk
    end
  end
end
