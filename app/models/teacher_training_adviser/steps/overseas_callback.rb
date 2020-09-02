module TeacherTrainingAdviser::Steps
  class OverseasCallback < Wizard::Step
    attribute :phone_call_scheduled_at, :datetime

    validates :phone_call_scheduled_at, presence: true

    def reviewable_answers
      {
        "callback_date" => phone_call_scheduled_at.to_date,
        "callback_time" => phone_call_scheduled_at.to_time, # rubocop:disable Rails/Date
      }
    end

    def skipped?
      returning_teacher = @store["returning_to_teaching"]
      not_equivalent_degree = @store["degree_options"] != TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_OPTIONS[:equivalent]
      not_overseas = @store["uk_or_overseas"] != TeacherTrainingAdviser::Steps::UkOrOverseas::OPTIONS[:overseas]

      returning_teacher || not_equivalent_degree || not_overseas
    end

    class << self
      def grouped_quotas
        GetIntoTeachingApiClient::CallbackBookingQuotasApi.new.get_callback_booking_quotas.group_by(&:day).reject do |day|
          Date.parse(day) == Time.zone.today
        end
      end
    end
  end
end
