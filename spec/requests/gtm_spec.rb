require "rails_helper"

RSpec.describe "Google Tag Manager", type: :request do
  it "has the GTM and fallback scripts" do
    get root_path
    expect(response.body).to include("data-gtm-id=\"123-ABC\"")
    expect(response.body).to include("https://www.googletagmanager.com/ns.html")
  end

  context "when the GTM_ID is not set" do
    before do
      allow(ENV).to receive(:[]).and_call_original
      allow(ENV).to receive(:[]).with("GTM_ID").and_return(nil)
    end

    it "does not have the GTM and fallback scripts" do
      get root_path
      expect(response.body).not_to include("data-gtm-id")
      expect(response.body).not_to include("https://www.googletagmanager.com/ns.html")
    end
  end
end
