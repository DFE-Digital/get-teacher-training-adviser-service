module CallbackBookingQuotas
  def callback_booking_quotas
    quotas = GetIntoTeachingApiClient::CallbackBookingQuotasApi.new.get_callback_booking_quotas
    quotas.reject do |quota|
      quota.start_at.in_time_zone.to_date == Time.zone.now.to_date
    end
  end
end
