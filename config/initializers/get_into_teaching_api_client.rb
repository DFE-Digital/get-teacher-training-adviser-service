GetIntoTeachingApiClient.configure do |config|
  config.host = "get-into-teaching-api-dev.london.cloudapps.digital"
  config.api_key["Authorization"] = Rails.application.credentials.config[:api_key]
end
