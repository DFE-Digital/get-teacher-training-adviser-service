# takes options = { default_ttl: Integer }

Typhoeus.configure do |config|
  cache = Typhoeus::Cache::Rails.new
end
