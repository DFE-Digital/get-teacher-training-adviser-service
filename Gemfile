source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby File.read(".ruby-version").chomp

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem "rails", "~> 7.0.3"

# Temporarily adding as part of Ruby 3.1 upgrade, we should be able
# to remove them once we're on Rails 7.0.1+
gem "net-imap", require: false
gem "net-pop", require: false
gem "net-smtp", require: false

# Use postgres as the database for Active Record
gem "pg"

# Use Puma as the app server
gem "puma", "~> 6.0"

gem "shakapacker", "6.5.6"

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", ">= 1.10.3", require: false

# Manage multiple processes i.e. web server and webpack
gem "foreman"

# Canonical meta tag
gem "canonical-rails"

gem "rack-cors"

gem "govuk_design_system_formbuilder"

gem "secure_headers"

# Fork needed for Ruby 3.1/Rails 7
gem "validates_timeliness", github: "mitsuru/validates_timeliness", branch: "rails7"

gem "dotenv-rails"

gem "dfe-analytics", github: "DFE-Digital/dfe-analytics", tag: "v1.8.1"

gem "rack-attack"

# redis for session store
gem "connection_pool"
gem "redis", "~> 4.8.1"

gem "prometheus-client"

# api client
gem "get_into_teaching_api_client_faraday", github: "DFE-Digital/get-into-teaching-api-ruby-client", require: "api/client"

gem "sentry-rails"
gem "sentry-ruby"

# Ignore cloudfront IPs when getting customer IP address
gem "actionpack-cloudfront"

gem "invisible_captcha"

gem "iso_country_codes"

gem "git_wizard", github: "DFE-Digital/get-into-teaching-wizard"

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem "byebug", platforms: %i[mri mingw x64_mingw]

  # GOV.UK interpretation of rubocop for linting Ruby
  gem "rubocop-govuk", require: false
  gem "scss_lint-govuk"

  # Static security scanner
  gem "brakeman", require: false

  # Debugging
  gem "pry-byebug"

  # Testing framework
  gem "rspec-rails", "~> 6.0.1"
  gem "rspec-sonarqube-formatter", "~> 1.5"
  gem "simplecov", "~> 0.22.0"
  # Adds support for Capybara system testing and selenium driver
  gem "capybara", "~> 3.38"
  # Factory builder
  gem "factory_bot_rails"
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem "listen", ">= 3.7.1", "< 3.9"
  gem "web-console", ">= 4.2.0"

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem "spring"
  gem "spring-watcher-listen", "~> 2.1.0"
end

group :test do
  gem "selenium-webdriver"
  gem "shoulda-matchers"
  gem "vcr"
  # Used when VCR is turned off to block HTTP requests.
  gem "webmock"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]

group :rolling, :preprod, :production, :pagespeed do
  # loading the Gem monkey patches rails logger
  # only load in prod-like environments when we actually need it
  gem "amazing_print"
  gem "rails_semantic_logger", ">= 4.10.0"
end
