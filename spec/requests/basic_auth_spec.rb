require "rails_helper"

RSpec.describe "Basic auth", type: :request do
  it "returns success if HTTPAUTH_USERNAME is not present" do
    get root_path
    expect(response).to be_successful
  end

  context "when HTTPAUTH_USERNAME is present" do
    let(:username) { "username" }
    let(:password) { "password" }

    before do
      allow(ENV).to receive(:[])
      allow(ENV).to receive(:[]).with("HTTPAUTH_USERNAME") { username }
      allow(ENV).to receive(:[]).with("HTTPAUTH_PASSWORD") { password }
    end

    it "returns unauthorized if credentials do not match" do
      get root_path, params: {}, headers: basic_auth_headers(username, "wrong-password")
      expect(response).to be_unauthorized
    end

    it "returns successs if credentials match" do
      get root_path, params: {}, headers: basic_auth_headers(username, password)
      expect(response).to be_successful
    end
  end

  def basic_auth_headers(username, password)
    value = ActionController::HttpAuthentication::Basic.encode_credentials(username, password)
    { "HTTP_AUTHORIZATION" => value }
  end
end
