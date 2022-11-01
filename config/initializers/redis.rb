if ENV["REDIS_URL"].blank? && Rails.application.config.x.vcap_services.present?
  redis_url = Rails.application.config.x.vcap_services.dig \
    "redis", 0, "credentials", "uri"

  ENV["REDIS_URL"] = redis_url if redis_url.present?
end

if ENV["REDIS_URL"]
  REDIS = ConnectionPool::Wrapper.new(size: 5, timeout: 3) do
    Redis.new(
      db: (Rails.env.test? ? ENV["TEST_ENV_NUMBER"].presence : nil),
      connect_timeout: 20, # Default is 5s but logic is we're better being slower booting than failing to boot
      reconnect_attempts: 1, # Allow for connection failure since Azure networking to Redis is showing some unreliability
    )
  end

  unless REDIS.ping == "PONG"
    raise "Could not connect to Redis"
  end
end
