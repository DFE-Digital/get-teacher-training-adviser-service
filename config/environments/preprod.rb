# Just use the production settings
require File.expand_path("production.rb", __dir__)

Rails.application.configure do
  config.x.git_api_endpoint = "https://get-into-teaching-api-test.london.cloudapps.digital"

  Rack::Attack.enabled = false
end
