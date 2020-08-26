module TeacherTrainingAdviser::Steps
  class UkCallback < Wizard::Step
    attribute :telephone, :string
    attribute :phone_call_scheduled_at, :datetime

    validates :telephone, telephone: true, presence: { message: "Enter a telephone number" }
    validates :phone_call_scheduled_at, presence: true

    def skipped?
      overseas = @store["uk_or_overseas"] != TeacherTrainingAdviser::Steps::UkOrOverseas::OPTIONS[:uk]
      not_equivalent_degree = @store["degree_options"] != TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_OPTIONS[:equivalent]
      returning_teacher = @store["returning_to_teaching"]

      overseas || not_equivalent_degree || returning_teacher
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
