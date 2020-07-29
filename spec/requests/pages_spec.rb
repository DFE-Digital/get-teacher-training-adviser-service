require "rails_helper"

RSpec.describe PagesController, type: :request do
  let(:policy) { GetIntoTeachingApiClient::PrivacyPolicy.new(id: "123", text: "Latest privacy policy") }
  let(:policy_id) { 123 }

  describe "get /privacy_policy" do
    context "viewing the latest privacy policy" do
      before do
        allow_any_instance_of(GetIntoTeachingApiClient::PrivacyPoliciesApi).to receive(:get_latest_privacy_policy).and_return(policy)
      end

      subject do
        get privacy_policy_path
        response
      end

      include_examples "policy_views"
    end

    context "viewing a specific privacy policy" do
      before do
        allow_any_instance_of(GetIntoTeachingApiClient::PrivacyPoliciesApi).to receive(:get_privacy_policy).and_return(policy)
      end

      subject do
        get privacy_policy_path(id: policy_id)
        response
      end

      include_examples "policy_views"
    end
  end
end
