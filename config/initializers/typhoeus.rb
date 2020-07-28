# takes   options = { default_ttl: integer }

Typhoeus.configure do |_config|
  cache = Typhoeus::Cache::Rails.new
end
