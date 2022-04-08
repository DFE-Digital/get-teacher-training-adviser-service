# Use the preprod settings
require File.expand_path("preprod.rb", __dir__)

Rails.application.configure do
  Rack::Attack.enabled = false
end
