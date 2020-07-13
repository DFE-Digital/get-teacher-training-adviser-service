class UkCallback < Base
  attribute :telephone_number, :string
  attribute :callback_slot, :string

  validates :telephone_number, length: { minimum: 5, too_short: "Telephone number is too short (minimum is 5 characters)" }, format: { with: /\A[0-9\s+]+\z/, message: "Enter a telephone number in the correct format" }

  validates :callback_slot, presence: { message: "Select a day and time for a callback" }

  def self.options
    quotas = ApiClient.get_callback_booking_quotas
    grouped_quotas = quotas.group_by { |q| q.day }
    options_hash = Hash.new { |hash, key| hash[key] = [] }
    grouped_quotas.each do |day, data|
      data.each do |x|
        options_hash[day] << [x.time_slot, x.time_slot]
      end
    end
    options_hash
  end

=begin
  attribute :callback_date, :date
  attribute "callback_date(3i)", :string
  attribute "callback_date(2i)", :string
  attribute "callback_date(1i)", :string
  attribute :callback_time, :string

  before_validation :make_a_date

  validates :telephone_number, length: { minimum: 5, too_short: "Telephone number is too short (minimum is 5 characters)" }, format: { with: /\A[0-9\s+]+\z/, message: "Enter a telephone number in the correct format" }
  validates :callback_date, presence: { message: "You need to enter a valid date" }
  validates :callback_time, presence: { message: "You need to complete this field" }

  validate :callback_date_cannot_be_in_past, :callback_date_limit

  def callback_date_cannot_be_in_past
    if callback_date.present? && callback_date < Date.today
      errors.add(:callback_date, "Date can't be in the past")
    end
  end

  def callback_date_limit
    if callback_date.present? && callback_date > Date.today.next_year(10)
      errors.add(:callback_date, "Date must be within 10 years")
    end
  end

  def make_a_date
    year = self.send("callback_date(1i)").to_i
    month = self.send("callback_date(2i)").to_i
    day = self.send("callback_date(3i)").to_i

    begin # catch invalid dates, e.g. 31 Feb
      self.callback_date = Date.new(year, month, day)
    rescue ArgumentError
      nil
    end
  end
=end
  def next_step
    "uk_completion"
  end
end
