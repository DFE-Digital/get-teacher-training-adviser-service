require "capybara/rspec"

JS_DRIVER = :selenium_chrome_headless

Capybara.register_driver JS_DRIVER do |app|
  options = ::Selenium::WebDriver::Chrome::Options.new

  options.add_argument("--headless")
  options.add_argument("--no-sandbox")
  options.add_argument("--disable-dev-shm-usage")
  options.add_argument("--window-size=1400,1400")

  Capybara::Selenium::Driver.new(app, browser: :chrome, options:)
end

Capybara.configure do |config|
  config.default_driver = :rack_test
  config.javascript_driver = JS_DRIVER
  config.server = :puma, { Silent: true }
end

RSpec.configure do |config|
  config.before do |example|
    Capybara.current_driver = JS_DRIVER if example.metadata[:js]
  end

  config.after do
    Capybara.use_default_driver
  end
end

# WebMock.disable_net_connect!(allow_localhost: true)
