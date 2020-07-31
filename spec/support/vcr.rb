VCR.configure do |config|
  config.cassette_library_dir = "spec/vcr"
  config.hook_into :typhoeus
  config.configure_rspec_metadata!
  config.before_record do |i|
    i.response.body.force_encoding("UTF-8")
  end
  Rails.application.credentials.config.each do |k, v|
    config.filter_sensitive_data("ENV[#{k}]") { v }
  end
end
