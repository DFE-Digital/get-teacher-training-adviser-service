require "rails_helper"

RSpec.describe "Redirecting beta-adviser-getintoteaching.education.gov.uk to adviser-getintoteaching.education.gov.uk", type: :request do
  before do
    allow(Rails.configuration.x).to receive(:enable_beta_redirects).and_return(true)
    host!("beta-adviser-getintoteaching.education.gov.uk")
  end

  it "redirects pages" do
    get "/a-very-nice-page?something=value"

    expect(response).to redirect_to("http://adviser-getintoteaching.education.gov.uk/a-very-nice-page?something=value")
  end
end
