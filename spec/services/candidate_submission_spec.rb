require "rails_helper"

RSpec.describe CandidateSubmission, :vcr do
  let(:session) do
    { registration: {
      "first_name" => "joe",
      "last_name" => "blogs",
      "email" => "jo@com",
      "subject_taught_id" => "6b793433-cd1f-e911-a979-000d3a20838a",
      "degree_status_id" => "222750000",
      "degree_type_id" => "222750000",
      "degree_subject" => "6b793433-cd1f-e911-a979-000d3a20838a",
      "uk_degree_grade_id" => "222750001",
      "preferred_education_phase_id" => StageInterestedTeaching::OPTIONS[:secondary],
      "has_gcse_maths_and_english_id" => "222750000",
      "planning_to_retake_gcse_maths_and_english_id" => "222750000",
      "has_gcse_science_id" => "222750000",
      "planning_to_retake_gcse_science_id" => "222750000",
      "initial_teacher_training_year_id" => "12917",
      "date_of_birth" => "1980-01-01T00:00:00.000+00:00",
      "country_id" => "00f5c2e6-74f9-e811-a97a-000d3a2760f2",
      "address_line1" => "163",
      "address_line2" => "hobbit hill",
      "address_city" => "baggistown",
      "address_postcode" => "SW1A 2ET",
      "telephone" => "123456",
      "accepted_policy_id" => ApiClient.get_latest_privacy_policy.id,
      "preferred_teaching_subject_id" => "6b793433-cd1f-e911-a979-000d3a20838a",
    } }
  end
  let(:equivalent_session) do
    { registration: {
      "first_name" => "joe",
      "last_name" => "blogs",
      "email" => "jo@com",
      "degree_status_id" => "222750000",
      "degree_type_id" => "222750005",
      "preferred_teaching_subject_id" => "6b793433-cd1f-e911-a979-000d3a20838a",
      "preferred_education_phase_id" => "222750000",
      "initial_teacher_training_year_id" => "12917",
      "date_of_birth" => "1980-01-01T00:00:00.000+00:00",
      "country_id" => "00f5c2e6-74f9-e811-a97a-000d3a2760f2",
      "address_line1" => "163",
      "address_line2" => "hobbit hill",
      "address_city" => "baggistown",
      "address_postcode" => "SW1A 2ET",
      "telephone" => "123456",
      "accepted_policy_id" => ApiClient.get_latest_privacy_policy.id,
      "phone_call_scheduled_at" => DateTime.now + 1.hour,
    } }
  end
  let(:candidate_submission) { described_class.new(session) }
  let(:equivalent_candidate_submission) { described_class.new(equivalent_session) }

  describe "#call" do
    context "as a returner" do
      it "submits the candidate info to the api" do
        session[:registration]["degree_options"] = ReturningTeacher::DEGREE_OPTIONS[:returner]
        expect { candidate_submission.call }.to_not raise_error
      end
    end

    context "as a degree candidate" do
      it "submits the candidate info to the api" do
        session[:registration]["degree_options"] = HaveADegree::DEGREE_OPTIONS[:degree]
        expect { candidate_submission.call }.to_not raise_error
      end
    end

    context "as a studying candidate" do
      it "submits the candidate info to the api" do
        session[:registration]["degree_options"] = HaveADegree::DEGREE_OPTIONS[:studying]
        expect { candidate_submission.call }.to_not raise_error
      end
    end

    context "as an equivalent candidate" do
      it "submits the candidate info to the api" do
        equivalent_session[:registration]["degree_options"] = HaveADegree::DEGREE_OPTIONS[:equivalent]
        expect { equivalent_candidate_submission.call }.to_not raise_error
      end
    end
  end
end
