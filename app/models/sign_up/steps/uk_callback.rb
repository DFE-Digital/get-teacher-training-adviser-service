module SignUp::Steps
  class UkCallback < Wizard::Step
    attribute :telephone, :string
    attribute :phone_call_scheduled_at, :datetime

    validates :telephone, length: { minimum: 5, too_short: "Telephone number is too short (minimum is 5 characters)" }, format: { with: /\A[0-9\s+]+\z/, message: "Enter a telephone number in the correct format" }
    validates :phone_call_scheduled_at, presence: true

    def skipped?
      @store["returning_to_teaching"] ||
        @store["degree_options"] != HaveADegree::DEGREE_OPTIONS[:equivalent] ||
        @store["uk_or_overseas"] != "UK"
    end

    class << self
      def grouped_quotas
        ApiClient.get_callback_booking_quotas.group_by(&:day).reject do |day|
          Date.parse(day) == Time.zone.today
        end
      end
    end
  end
end
