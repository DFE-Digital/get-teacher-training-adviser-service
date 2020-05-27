require "rails_helper"

RSpec.describe SitemapsController, type: :request do

  describe "GET #sitemap" do
    it "returns success" do
      get sitemap_path(:format => :xml)
      expect(response).to have_http_status(:success)
      expect(response.body).to include("loc")
      expect(response.body).to include("lastmod")
    end
  end

  
end
