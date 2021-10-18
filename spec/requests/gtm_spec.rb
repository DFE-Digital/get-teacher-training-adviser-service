require "rails_helper"

RSpec.describe "Google Tag Manager", type: :request do
  before do
    allow(Rails.application.config.x).to receive(:legacy_tracking_pixels) { legacy_tracking_pixels }
  end

  context "when legacy tracking pixels are disabled" do
    let(:legacy_tracking_pixels) { false }

    it "has the GTM and fallback scripts" do
      get root_path
      expect(response.body).to include("data-gtm-id=\"123-ABC\"")
      expect(response.body).to include("https://www.googletagmanager.com/ns.html")
    end

    context "when the GTM_ID is not set" do
      before do
        allow(ENV).to receive(:[]).with("GTM_ID").and_return(nil)
      end

      it "does not have the GTM and fallback scripts" do
        get root_path
        expect(response.body).not_to include("data-gtm-id")
        expect(response.body).not_to include("https://www.googletagmanager.com/ns.html")
      end
    end
  end

  context "when legacy tracking pixels are enabled" do
    let(:legacy_tracking_pixels) { true }

    it "does not have the GTM and fallback scripts" do
      get root_path
      expect(response.body).not_to include("data-gtm-id")
      expect(response.body).not_to include("https://www.googletagmanager.com/ns.html")
    end
  end
end
