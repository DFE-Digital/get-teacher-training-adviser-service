module TeacherTrainingAdviser::Steps
  class OverseasTelephone < Wizard::Step
    attribute :telephone, :string

    validates :telephone, telephone: true, allow_blank: true

    def skipped?
      @store["uk_or_overseas"] == TeacherTrainingAdviser::Steps::UkOrOverseas::OPTIONS[:uk]
    end
  end
end
