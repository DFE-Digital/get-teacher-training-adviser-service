require "rails_helper"

RSpec.describe "Robots.txt", type: :request do
  before { get "/robots.txt" }
  subject { response.body }

  it do
    is_expected.to eq(
      <<~ROBOTS,
        User-agent: *
        Allow: /$
        Disallow: /

        Sitemap: adviser-getintoteaching.education.gov.uk/sitemap.xml
      ROBOTS
    )
  end
end
