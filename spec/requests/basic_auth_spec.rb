require "rails_helper"

RSpec.describe "Basic auth", type: :request do
  let(:username) { "username" }
  let(:password) { "password" }

  before do
    allow(Rails.application.credentials.config).to receive(:[]).and_call_original
    allow(Rails.application.credentials.config).to receive(:[]).with(:http_auth) { "#{username}=#{password}" }
  end

  it "is not enforced on non-production environments" do
    get root_path
    expect(response).to be_successful
  end

  context "when production" do
    before { allow(Rails.env).to receive(:production?) { true } }

    it "is not enforced" do
      get root_path
      expect(response).to be_successful
    end
  end

  context "when production-like (but not production)" do
    before do
      allow(Rails.env).to receive(:test?) { false }
      allow(Rails.env).to receive(:development?) { false }
      allow(Rails.env).to receive(:production?) { false }
    end

    it "returns unauthorized if credentials do not match" do
      get root_path, params: {}, headers: basic_auth_headers(username, "wrong-password")
      expect(response).to be_unauthorized
    end

    it "returns success and sets a user session if credentials match" do
      get root_path, params: {}, headers: basic_auth_headers(username, password)
      expect(response).to be_successful
      expect(request.session[:username]).to eq(username)
    end
  end
end
