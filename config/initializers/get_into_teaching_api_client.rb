GetIntoTeachingApiClient.configure do |config|
 endpoint = ENV["GIT_API_ENDPOINT"].presence || Rails.application.config.x.git_api_endpoint.presence
  if endpoint
    parsed = URI.parse(endpoint)
    config.host = parsed.hostname
  end

  config.api_key["Authorization"] = ENV["GIT_API_TOKEN"].presence || Rails.application.credentials.config[:api_key].presence
end
