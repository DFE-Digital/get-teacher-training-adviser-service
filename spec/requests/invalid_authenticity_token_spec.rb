require "rails_helper"

RSpec.describe "Invalid Authenticity Token", type: :request do
  let(:identity) { build(:identity) }

  before do
    ActionController::Base.allow_forgery_protection = true
  end

  after do
    ActionController::Base.allow_forgery_protection = false
  end

  describe "with an invalid authenticity token" do
    it "redirects to the root path" do
        params = { "authenticity_token" => "expired", identity: { email: "email@address.com", first_name: "first", last_name: "last" } }
        post registrations_path(identity.step_name), params: params
        assert_redirected_to root_path
    end
  end

end