# Just use the production settings
require File.expand_path("production.rb", __dir__)

Rails.application.configure do
  config.x.git_api_endpoint = "https://get-into-teaching-api-dev.london.cloudapps.digital"
  config.x.enable_beta_redirects = false
  config.x.dfe_analytics = true
end
