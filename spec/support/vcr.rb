VCR.configure do |config|
  config.cassette_library_dir = "spec/vcr"
  config.hook_into :typhoeus
  config.configure_rspec_metadata!
end
