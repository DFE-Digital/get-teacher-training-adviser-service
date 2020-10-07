module TeacherTrainingAdviser::Steps
  class OverseasTimeZone < Wizard::Step
    attribute :telephone, :string

    validates :telephone, telephone: true, presence: true

    def reviewable_answers
      {
        "telephone" => telephone,
      }
    end

    def skipped?
      returning_teacher = @store["returning_to_teaching"]
      not_equivalent_degree = @store["degree_options"] != TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_OPTIONS[:equivalent]
      not_overseas = @store["uk_or_overseas"] != TeacherTrainingAdviser::Steps::UkOrOverseas::OPTIONS[:overseas]

      returning_teacher || not_equivalent_degree || not_overseas
    end
  end
end
