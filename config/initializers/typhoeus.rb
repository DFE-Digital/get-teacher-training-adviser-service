# takes   options = { default_ttl: integer }

Typhoeus.configure do |config|
  config.cache = Typhoeus::Cache::Rails.new
  config.instance_variable_set(:@default_ttl, 5)
end
