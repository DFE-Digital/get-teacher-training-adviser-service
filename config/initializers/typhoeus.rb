Typhoeus::Config.cache = Typhoeus::Cache::Rails.new
# temporarily allow updated requests as not respondng to etags
Typhoeus::Config.cache.instance_variable_set(:@default_ttl, 5)