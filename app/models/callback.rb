class Callback < Base
  attribute :telephone, :string
  attribute :callback_slot, :string

  validates :telephone, length: { minimum: 5, too_short: "Telephone number is too short (minimum is 5 characters)" }, format: { with: /\A[0-9\s+]+\z/, message: "Enter a telephone number in the correct format" }

  validates :callback_slot, callbacks: { method: :get_callback_booking_quotas }

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
