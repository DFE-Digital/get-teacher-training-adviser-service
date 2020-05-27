require "rails_helper"

RSpec.describe SitemapsController, type: :controller do
  describe "GET #sitemap" do
    it "returns success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  
end
