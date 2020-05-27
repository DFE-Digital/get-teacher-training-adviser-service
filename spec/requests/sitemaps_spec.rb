require "rails_helper"

RSpec.describe SitemapsController, type: :request do
  
  describe "GET #sitemap" do
    it "returns success" do
      get :index, :format => :xml
      expect(response).to have_http_status(:success)
      expect(response).to have_tag("loc")
    end
  end

  
end
