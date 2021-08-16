require "rails_helper"

RSpec.describe HealthchecksController, type: :request do
  describe "get /healthcheck.json" do
    it "returns a success response" do
      get healthcheck_path
      expect(response).to have_http_status(:ok)
    end
  end
end
