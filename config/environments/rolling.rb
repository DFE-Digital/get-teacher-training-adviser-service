# Just use the production settings
require File.expand_path("production.rb", __dir__)

Rails.application.configure do
  # Override any production defaults here
  # Use a different cache store in production.
  redis_url = JSON.parse(ENV['VCAP_SERVICES'])[:redis][0][:credentials][:uri]
  config.cache_store = :redis_cache_store { url: redis_url }
end
