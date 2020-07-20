module Equivalent
  class UkCallback < Callback
    def self.options
      quotas = ApiClient.get_callback_booking_quotas
      grouped_quotas = quotas.group_by(&:day)
      options_hash = Hash.new { |hash, key| hash[key] = [] }
      grouped_quotas.each do |day, data|
        data.each do |x|
          options_hash[day] << [x.time_slot, x.id]
        end
      end
      options_hash
    end

    def next_step
      "equivalent/uk_completion"
    end
  end
end
