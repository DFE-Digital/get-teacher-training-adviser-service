require "rails_helper"

RSpec.describe ApiClient do
  subject { described_class }

  describe "class methods" do
    it "proxies type API calls to the GetIntoTeachingApiClient" do
      type_methods = %i[
        get_teaching_subjects
        get_candidate_initial_teacher_training_years
        get_candidate_preferred_education_phases
        get_candidate_retake_gcse_status
        get_qualification_degree_status
        get_qualification_uk_degree_grades
        get_country_types
      ]

      type_methods.each do |method|
        expect_any_instance_of(GetIntoTeachingApiClient::TypesApi).to receive(method).once
        subject.send(method)
      end
    end

    it "proxies privacy policy API calls to the GetIntoTeachingApiClient" do
      expect_any_instance_of(GetIntoTeachingApiClient::PrivacyPoliciesApi).to \
        receive(:get_latest_privacy_policy).once
      subject.get_latest_privacy_policy

      policy_id = 123_456
      expect_any_instance_of(GetIntoTeachingApiClient::PrivacyPoliciesApi).to \
        receive(:get_privacy_policy).with(policy_id).once
      subject.get_privacy_policy(policy_id)
    end

    it "proxies callback booking quota API calls to the GetIntoTeachingApiClient" do
      expect_any_instance_of(GetIntoTeachingApiClient::CallbackBookingQuotasApi).to \
        receive(:get_callback_booking_quotas).once
      subject.get_callback_booking_quotas
    end

    it "proxies TTA API calls to the GetIntoTeachingApiClient" do
      body = { "customer_info" => "hi there" }
      expect_any_instance_of(GetIntoTeachingApiClient::TeacherTrainingAdviserApi).to \
        receive(:sign_up_teacher_training_adviser_candidate).with(body).once
      subject.sign_up_teacher_training_adviser_candidate(body)
    end
  end
end
