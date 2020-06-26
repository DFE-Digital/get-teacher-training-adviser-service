desc "Notify Google of the updated sitemp"
task :sitemap do
  require "net/http"
  Net::HTTP.get(
    "www.google.com",
    "/ping?sitemap=" +
      URI.escape(app.root_url.to_s + "sitemap.xml"),
  )
end
# app.root_url is "http://www.example.com/" for localhost. Can be configured in Application controller
# or environment via default_url_options
