module CallbackBookingQuotas
  def callback_booking_quotas
    quotas = GetIntoTeachingApiClient::CallbackBookingQuotasApi.new.get_callback_booking_quotas
    quotas.reject do |quota|
      quota.start_at.in_time_zone.today?
    end
  end
end
