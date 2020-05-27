desc 'Notify Google of the updated sitemp'
task :sitemap do
    require 'net/http'
    Net::HTTP.get(
        'www.google.com',
        '/ping?sitemap=' +
        URI.escape('http://domain.com/sitemap.xml')
    )
end