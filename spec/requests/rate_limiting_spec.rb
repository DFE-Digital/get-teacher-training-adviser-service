require "rails_helper"

RSpec.describe "Rate limiting" do
  let(:ip) { "1.2.3.4" }

  before do
    allow_any_instance_of(GetIntoTeachingApiClient::CandidatesApi).to \
      receive(:create_candidate_access_token)
  end

  it_behaves_like "an IP-based rate limited endpoint", "POST /csp_reports", 5, 1.minute do
    def perform_request
      post csp_reports_path, params: {}.to_json, headers: { "REMOTE_ADDR" => ip }
    end
  end

  it_behaves_like "an IP-based rate limited endpoint", "PATCH /teacher_training_adviser/sign_up/identity", 5, 1.minute do
    def perform_request
      key = TeacherTrainingAdviser::Steps::Identity.model_name.param_key
      params = { key => { first_name: "first", last_name: "last", email: "email@address.com" } }
      patch teacher_training_adviser_step_path(:identity), params: params, headers: { "REMOTE_ADDR" => ip }
    end
  end

  it_behaves_like "an IP-based rate limited endpoint", "GET */resend_verification", 5, 1.minute do
    def perform_request
      get resend_verification_teacher_training_adviser_steps_path(redirect_path: "redirect/path"), headers: { "REMOTE_ADDR" => ip }
    end
  end

  it_behaves_like "an IP-based rate limited endpoint", "PATCH */teacher_training_adviser/sign_up/accept_privacy_policy", 5, 1.minute do
    def perform_request
      key = TeacherTrainingAdviser::Steps::AcceptPrivacyPolicy.model_name.param_key
      params = { key => { accepted_policy_id: "0a203956-e935-ea11-a813-000d3a44a8e9" } }
      patch teacher_training_adviser_step_path(:accept_privacy_policy), params: params, headers: { "REMOTE_ADDR" => ip }
    end
  end
end
