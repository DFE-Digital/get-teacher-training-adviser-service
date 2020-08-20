module CallbackHelper
  def format_booking_quotas(quotas_by_day, time_zone = "GMT")
    quotas_by_day.transform_values do |quotas|
      quotas.map do |quota|
        start_at = quota.start_at.in_time_zone(time_zone)
        end_at = quota.end_at.in_time_zone(time_zone)

        ["#{start_at.strftime('%I:%M %P')} - #{end_at.strftime('%I:%M %P')}", quota.start_at]
      end
    end
  end
end
