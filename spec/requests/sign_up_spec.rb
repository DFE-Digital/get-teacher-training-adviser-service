require "rails_helper"

RSpec.describe TeacherTrainingAdviser::StepsController do
  let(:model) { TeacherTrainingAdviser::Steps::Identity }
  let(:step_path) { teacher_training_adviser_step_path model.key }

  describe "#show" do
    before { get step_path }
    subject { response }
    it { is_expected.to have_http_status :success }
  end

  describe "#update" do
    let(:key) { model.model_name.param_key }

    subject do
      patch step_path, params: { key => params }
      response
    end

    context "with valid data" do
      before do
        # Emulate an unsuccessful matchback response from the API.
        expect_any_instance_of(GetIntoTeachingApiClient::CandidatesApi).to \
          receive(:create_candidate_access_token)
          .and_raise(GetIntoTeachingApiClient::ApiError)
      end

      let(:params) { { first_name: "John", last_name: "Doe", email: "john@doe.com" } }
      it { is_expected.to redirect_to teacher_training_adviser_step_path("returning_teacher") }
    end

    context "with invalid data" do
      let(:params) { { "email" => "invaild-email" } }
      it { is_expected.to have_http_status :success }
    end

    context "for last step" do
      let(:steps) { TeacherTrainingAdviser::Wizard.steps }
      let(:model) { steps.last }
      let(:params) { { accepted_policy_id: "abc-123" } }

      context "when all valid" do
        before do
          steps.each do |step|
            allow_any_instance_of(step).to receive(:valid?).and_return true
          end

          expect_any_instance_of(GetIntoTeachingApiClient::TeacherTrainingAdviserApi).to \
            receive(:sign_up_teacher_training_adviser_candidate).once
        end

        it { is_expected.to redirect_to completed_teacher_training_adviser_steps_path }
      end

      context "when there is an invalid step" do
        let(:invalid_step) { steps.first }

        before do
          steps.each do |step|
            allow_any_instance_of(step).to receive(:valid?).and_return true

            expect_any_instance_of(GetIntoTeachingApiClient::TeacherTrainingAdviserApi).to_not \
              receive(:sign_up_teacher_training_adviser_candidate)
          end

          allow_any_instance_of(invalid_step).to receive(:valid?).and_return false
        end

        it { is_expected.to redirect_to teacher_training_adviser_step_path(invalid_step.key) }
      end
    end
  end

  describe "#completed" do
    subject do
      get completed_teacher_training_adviser_steps_path
      response
    end
    it { is_expected.to have_http_status :success }
  end

  describe "#resend_verification" do
    before do
      expect_any_instance_of(GetIntoTeachingApiClient::CandidatesApi).to \
        receive(:create_candidate_access_token)
    end

    subject do
      get resend_verification_teacher_training_adviser_steps_path(redirect_path: "redirect/path")
      response
    end
    it { is_expected.to redirect_to("redirect/path") }
  end
end
