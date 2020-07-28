require "rails_helper"

RSpec.describe PagesController, type: :request do
  let(:policy) { GetIntoTeachingApiClient::PrivacyPolicy.new(id: "123", text: "Latest privacy policy") }

  describe "get /privacy_policy" do
    context "viewing the latest privacy policy" do
      before do
        allow_any_instance_of(GetIntoTeachingApiClient::PrivacyPoliciesApi).to receive(:get_latest_privacy_policy).and_return(policy)
      end

      subject do
        get privacy_policy_path
        response
      end

      it "returns a success response" do
        expect(subject).to have_http_status(200)
      end

      it "includes the policy text" do
        expect(subject.body).to include(policy.text)
      end
    end

    context "viewing a specific privacy policy" do
      subject do
        get privacy_policy_path(id: policy.id)
        response
      end

      before do
        allow_any_instance_of(GetIntoTeachingApiClient::PrivacyPoliciesApi).to receive(:get_privacy_policy).with(policy.id).and_return(policy)
      end

      it "returns a success response" do
        expect(subject).to have_http_status(200)
      end

      it "includes the policy text" do
        expect(subject.body).to include(policy.text)
      end
    end
  end
end
