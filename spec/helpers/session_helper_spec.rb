require "rails_helper"

RSpec.describe SessionHelper, type: :helper do
  describe "#show_session" do
    context "with a session value" do
      it "returns the value capitalized" do
        session[:registration] = { "identity" => "me" }
        expect(show_session("identity")).to eq("Me")
      end
    end
    context "with uk as the value" do
      it "returns the value capitalised" do
        session[:registration] = { "identity" => "uk" }
        expect(show_session("identity")).to eq("UK")
        session[:registration] = { "identity" => "UK" }
        expect(show_session("identity")).to eq("UK")
        session[:registration] = { "identity" => "Uk" }
        expect(show_session("identity")).to eq("UK")
      end
    end
    context "with missing sesson value" do
      it "returns nil" do
        session[:registration] = {}
        expect(show_session("identity")).to eq(nil)
      end
    end
  end

  describe "#show_link" do
    it "returns a link to the registration step" do
      expect(show_link("identity")).to eq("<a href=\"/registrations/identity\">Change</a>")
    end
  end

  describe "#show_dob" do
    it "returns the session date_of_birth value" do
      session[:registration] = { "date_of_birth" => Date.new(2000, 10, 1) }
      expect(show_dob).to eq("01 10 2000")
    end
  end

  describe "#show_yes_or_no" do
    it "returns yes if the value is 222_750_000" do
      session[:registration] = { "test" => 222_750_000 }
      expect(show_yes_or_no("test")).to eq("Yes")
    end

    it "returns no if the value is not 222_750_000" do
      session[:registration] = { "test" => 222_750_001 }
      expect(show_yes_or_no("test")).to eq("No")
    end
  end

  describe "#show_callback_date" do
    it "returns the session callback_date value as a string" do
      session[:registration] = {
        "phone_call_scheduled_at" => ApiClient.get_callback_booking_quotas.first.start_at,
      }
      expect(show_callback_date).to be_instance_of(String)
      expect(show_callback_date).not_to be_empty
    end
  end

  describe "#show_callback_time" do
    it "returns the session callback_time value as a string separated with '-'" do
      session[:registration] = {
        "phone_call_scheduled_at" => ApiClient.get_callback_booking_quotas.first.start_at,
      }
      expect(show_callback_time).to include("-")
    end
  end

  describe "#show_uk_address" do
    it "returns the session address values" do
      session[:registration] = { "address_line1" => "22",
                                 "address_line2" => "acacia avenue",
                                 "address_city" => "bradford",
                                 "address_postcode" => "tr1 1uf" }
      expect(show_uk_address).to eq("22<br />acacia avenue<br />bradford<br />tr1 1uf")
    end
  end

  describe "#show_name" do
    it "returns the session name value" do
      session[:registration] = { "first_name" => "joe",
                                 "last_name" => "bloggs" }
      expect(show_name).to eq("Joe Bloggs")
    end
  end

  describe "#show_email" do
    it "returns the session email value" do
      session[:registration] = {
        "email" => "jo@bloggs.com",
      }
      expect(show_email).to eq("jo@bloggs.com")
    end
  end

  describe "#show_phone" do
    it "returns the session telephone value" do
      session[:registration] = {
        "telephone" => "1234567",
      }
      expect(show_phone).to eq("1234567")
    end
  end

  describe "#show_country" do
    it "returns the session country_id name" do
      session[:registration] = {
        "country_id" => "0df4c2e6-74f9-e811-a97a-000d3a2760f2",
      }
      expect(show_country).to eq("Australia")
    end
  end

  describe "#show_true_or_false" do
    it "converts bools to yes or no" do
      session[:registration] = {
        "planning_to_retake_gcse_science_id" => true,
      }
      expect(show_true_or_false("planning_to_retake_gcse_science_id")).to eq("Yes")
      session[:registration] = {
        "planning_to_retake_gcse_science_id" => false,
      }
      expect(show_true_or_false("planning_to_retake_gcse_science_id")).to eq("No")
    end
  end

  describe "#show_subject" do
    it "returns the session 'question' name" do
      session[:registration] = {
        "subject_taught_id" => "6b793433-cd1f-e911-a979-000d3a20838a",
      }
      expect(show_subject("subject_taught_id")).to eq("Art")
    end
  end

  describe "#show_have_a_degree" do
    it "returns the session 'degree_status_id' value" do
      session[:registration] = {
        "degree_status_id" => HaveADegree::OPTIONS[:yes],
      }
      expect(show_have_a_degree).to eq("Yes")
    end
  end

  describe "#show_what_degree_class" do
    it "returns the session 'uk_degree_grade_id' value" do
      session[:registration] = {
        "uk_degree_grade_id" => 222_750_001,
      }
      expect(show_what_degree_class).to eq("First class")
    end
  end

  describe "#show_stage_interested_teaching" do
    it "returns the session 'preferred_education_phase_id' value" do
      session[:registration] = {
        "preferred_education_phase_id" => StageInterestedTeaching::OPTIONS[:primary],
      }
      expect(show_stage_interested_teaching).to eq("Primary")
    end
  end

  describe "#show_start_teacher_training" do
    it "returns the session 'initial_teacher_training_year_id' value" do
      session[:registration] = {
        "initial_teacher_training_year_id" => 12_917,
      }
      expect(show_start_teacher_training).to eq("Not sure")
    end
  end

  describe "#show_stage_of_degree" do
    it "returns the session 'stage_of_degree' value" do
      session[:registration] = {
        "degree_status_id" => 222_750_001,
      }
      expect(show_stage_of_degree).to eq("Final year")
    end
  end
end
