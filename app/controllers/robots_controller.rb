class RobotsController < ApplicationController
  layout :none

  # we're serving this from here rather than /public so we can apply any
  # redirects from beta-beta-adviser-getintoteaching.education.gov.uk to
  # adviser-getintoteaching.education.gov.uk - hopefully preventing any search
  # engines from indexing the site under the beta domain
  def show
    render plain: <<~ROBOTS
      User-agent: *
      Allow: /$
      Disallow: /

      Sitemap: adviser-getintoteaching.education.gov.uk/sitemap.xml
    ROBOTS
  end
end
