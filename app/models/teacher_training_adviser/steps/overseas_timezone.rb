module TeacherTrainingAdviser::Steps
  class OverseasTimezone < Wizard::Step
    attribute :time_zone, :string
    attribute :telephone, :string

    validates :time_zone, presence: { message: "Select a time zone" }
    validates :telephone, telephone: true, presence: { message: "Enter a telephone number" }

    def reviewable_answers
      super.tap do |answers|
        answers["time_zone"] = time_zone.to_s
      end
    end

    def skipped?
      returning_teacher = @store["returning_to_teaching"]
      not_equivalent_degree = @store["degree_options"] != TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_OPTIONS[:equivalent]
      not_overseas = @store["uk_or_overseas"] != TeacherTrainingAdviser::Steps::UkOrOverseas::OPTIONS[:overseas]

      returning_teacher || not_equivalent_degree || not_overseas
    end
  end
end