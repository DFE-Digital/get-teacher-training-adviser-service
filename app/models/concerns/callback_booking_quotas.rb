module CallbackBookingQuotas
  def callback_booking_quotas
    @callback_booking_quotas ||=
      GetIntoTeachingApiClient::CallbackBookingQuotasApi.new.get_callback_booking_quotas
  end
end
