module CallbackHelper
  def format_booking_quotas(quotas, time_zone = "GMT")
    quotas_excluding_today = quotas.reject do |quota|
      quota.start_at.in_time_zone(time_zone).to_date == DateTime.now.in_time_zone(time_zone).to_date
    end

    quotas_by_day = quotas_excluding_today.group_by do |quota|
      quota.start_at.in_time_zone(time_zone).to_date.to_formatted_s(:govuk_date_long)
    end

    quotas_by_day.transform_values do |quotas_on_day|
      quotas_on_day.map do |quota|
        start_at = quota.start_at.in_time_zone(time_zone)
        end_at = quota.end_at.in_time_zone(time_zone)

        ["#{start_at.to_formatted_s(:govuk_time_with_period)} - #{end_at.to_formatted_s(:govuk_time_with_period)}", quota.start_at]
      end
    end
  end
end
