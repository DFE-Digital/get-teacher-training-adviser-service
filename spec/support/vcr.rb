VCR.configure do |config|
  config.cassette_library_dir = "spec/vcr"
  config.hook_into :typhoeus
  config.configure_rspec_metadata!
  Rails.application.credentials.config.each do |k,v|
    config.filter_sensitive_data("ENV[#{k}]") { v }
  end
end
