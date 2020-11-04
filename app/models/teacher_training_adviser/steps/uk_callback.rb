module TeacherTrainingAdviser::Steps
  class UkCallback < Wizard::Step
    extend CallbackBookingQuotas

    attribute :telephone, :string
    attribute :phone_call_scheduled_at, :datetime

    validates :telephone, telephone: true, presence: true
    validates :phone_call_scheduled_at, presence: true

    before_validation if: :telephone do
      self.telephone = telephone.to_s.strip.presence
    end

    def reviewable_answers
      {
        "callback_date" => phone_call_scheduled_at&.to_date,
        "callback_time" => phone_call_scheduled_at&.to_time, # rubocop:disable Rails/Date
      }
    end

    def skipped?
      overseas = @store["uk_or_overseas"] != TeacherTrainingAdviser::Steps::UkOrOverseas::OPTIONS[:uk]
      not_equivalent_degree = @store["degree_options"] != TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_OPTIONS[:equivalent]
      returning_teacher = @store["returning_to_teaching"]

      overseas || not_equivalent_degree || returning_teacher
    end
  end
end
