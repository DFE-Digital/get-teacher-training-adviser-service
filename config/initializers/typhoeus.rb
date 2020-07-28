# takes   options = { default_ttl: integer }

Typhoeus.configure do |config|
  cache = Typhoeus::Cache::Rails.new
end
