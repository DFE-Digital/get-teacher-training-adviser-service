if Rails.env.preprod? || Rails.env.rolling?
  require "cloud_front_ip_filter"
  CloudFrontIpFilter.configure!
end
