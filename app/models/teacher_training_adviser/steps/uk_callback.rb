module TeacherTrainingAdviser::Steps
  class UkCallback < Wizard::Step
    attribute :telephone, :string
    attribute :phone_call_scheduled_at, :datetime

    validates :telephone, telephone: true, presence: { message: "Enter a telephone number" }
    validates :phone_call_scheduled_at, presence: true

    def reviewable_answers
      {
        "callback_date" => phone_call_scheduled_at.strftime("%d %m %Y"),
        "callback_time" => phone_call_scheduled_at.strftime("%H:%M"),
      }
    end

    def skipped?
      @store["returning_to_teaching"] ||
        @store["degree_options"] != TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_OPTIONS[:equivalent] ||
        @store["uk_or_overseas"] != TeacherTrainingAdviser::Steps::UkOrOverseas::OPTIONS[:uk]
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
