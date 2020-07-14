class UkCallback < Base
  attribute :telephone_number, :string
  attribute :callback_slot, :string

  validates :telephone_number, length: { minimum: 5, too_short: "Telephone number is too short (minimum is 5 characters)" }, format: { with: /\A[0-9\s+]+\z/, message: "Enter a telephone number in the correct format" }

  validates :callback_slot, types: { method: :get_callback_booking_quotas }

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
    "uk_completion"
  end
end
