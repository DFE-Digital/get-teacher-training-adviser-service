Raven.configure do |config|
  config.environments = %w(rolling preprod)
  config.dsn = ENV['SENTRY_DSN']
end
