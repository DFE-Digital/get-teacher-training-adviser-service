require "rails_helper"

RSpec.describe "Robots.txt", type: :request do
  subject { response.body }

  before { get "/robots.txt" }

  it do
    expect(subject).to eq(
      <<~ROBOTS,
        User-agent: *
        Allow: /$
        Disallow: /

        Sitemap: adviser-getintoteaching.education.gov.uk/sitemap.xml
      ROBOTS
    )
  end
end
