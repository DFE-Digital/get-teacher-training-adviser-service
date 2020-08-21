module SignUp::Steps
  class UkCallback < Wizard::Step
    attribute :telephone, :string
    attribute :phone_call_scheduled_at, :datetime

    validates :telephone, length: { minimum: 5, too_short: "Telephone number is too short (minimum is 5 characters)" }, format: { with: /\A[0-9\s+]+\z/, message: "Enter a telephone number in the correct format" }
    validates :phone_call_scheduled_at, presence: true

    def skipped?
      @store["degree_options"] != HaveADegree::DEGREE_OPTIONS[:equivalent] ||
        @store["uk_or_overseas"] != "UK"
    end

    def self.options
      quotas = ApiClient.get_callback_booking_quotas
      grouped_quotas = quotas.group_by(&:day)
      options_hash = Hash.new { |hash, key| hash[key] = [] }
      grouped_quotas.each do |day, data|
        data.each do |x|
          gmt_start_slot = Time.zone.parse(x.start_at.to_s).strftime("%I:%M %P")
          gmt_end_slot = Time.zone.parse(x.end_at.to_s).strftime("%I:%M %P")
          options_hash[day] << [gmt_start_slot.to_s + " - " + gmt_end_slot.to_s, x.start_at]
        end
      end
      options_hash
    end
  end
end
