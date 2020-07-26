require "rails_helper"

RSpec.describe PagesController, :vcr, type: :request do
  let(:policy) { GetIntoTeachingApiClient::PrivacyPolicy.new(id: "123", text: "Latest privacy policy") }

  describe "get/privacy_policy" do
    context "viewing the latest privacy policy" do
      before do
        allow_any_instance_of(GetIntoTeachingApiClient::PrivacyPoliciesApi).to receive(:get_latest_privacy_policy).and_return(policy)
      end

      subject do
        get privacy_policy_path
        response
      end

      include_examples "privacy_policy"
    end

    context "viewing a specified privacy policy" do
      before do
        allow_any_instance_of(GetIntoTeachingApiClient::PrivacyPoliciesApi).to receive(:get_privacy_policy).with(policy.id).and_return(policy)
      end

      subject do
        get privacy_policy_path(id: policy.id)
        response
      end

      include_examples "privacy_policy"
    end
  end

end