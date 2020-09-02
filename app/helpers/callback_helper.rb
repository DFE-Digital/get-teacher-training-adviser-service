module CallbackHelper
  def format_booking_quotas(_quotas_by_day, time_zone = "GMT")
    result = GetIntoTeachingApiClient::CallbackBookingQuotasApi.new.get_callback_booking_quotas
    arr = []
    result.each do |r|
      r.start_at = r.start_at.in_time_zone(time_zone)
      arr << r
    end
    arr
    barr = arr.group_by(&:day).reject do |day|
      Date.parse(day) == Time.zone.today
    end

    barr.transform_values do |quotas|
      quotas.map do |quota|
        start_at = quota.start_at.in_time_zone(time_zone)
        end_at = quota.end_at.in_time_zone(time_zone)

        ["#{start_at.strftime('%I:%M %P')} - #{end_at.strftime('%I:%M %P')} ", quota.start_at.in_time_zone(time_zone)]
      end
    end
  end
end
