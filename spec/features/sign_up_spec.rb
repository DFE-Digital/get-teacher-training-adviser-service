require "rails_helper"

RSpec.feature "Sign up for a teacher training adviser", type: :feature do
  RETURNING_TO_TEACHING = 222_750_001
  INTERESTED_IN_TEACHING = 222_750_000
  EDUCATION_PHASE_PRIMARY = 222_750_000
  EDUCATION_PHASE_SECONDARY = 222_750_001
  DEGREE_STATUS_HAS_DEGREE = 222_750_000
  DEGREE_TYPE_EQUIVALENT = 222_750_005
  DEGREE_TYPE_DEGREE = 222_750_000
  TEACHER_TRAINING_YEAR_2022 = 22_304
  UK_DEGREE_GRADE_2_2 = 222_750_003
  DEGREE_STATUS_FIRST_YEAR = 222_750_003
  HAS_GCSE = 222_750_000
  SUBJECT_PHYSICS = "ac2655a1-2afa-e811-a981-000d3a276620".freeze
  SUBJECT_PSYCHOLOGY = "b22655a1-2afa-e811-a981-000d3a276620".freeze

  context "a new candidate" do
    before do
      # Emulate an unsuccessful matchback response from the API.
      expect_any_instance_of(GetIntoTeachingApiClient::CandidatesApi).to \
        receive(:create_candidate_access_token)
        .and_raise(GetIntoTeachingApiClient::ApiError)
    end

    scenario "that is a returning teacher" do
      visit teacher_training_adviser_steps_path

      expect(page).to have_css "h1", text: "About you"
      fill_in_identity_step
      click_on "Continue"

      expect(page).to have_css "h1", text: "Are you returning to teaching?"
      choose "Yes"
      click_on "Continue"

      expect(page).to have_css "h1", text: "Do you have your previous teacher reference number?"
      choose "Yes"
      click_on "Continue"

      expect(page).to have_css "h1", text: "What is your previous teacher reference number?"
      fill_in "Teacher reference number (optional)", with: "1234"
      click_on "Continue"

      expect(page).to have_css "h1", text: "Which main subject did you previously teach?"
      select "Psychology"
      click_on "Continue"

      expect(page).to have_css "h1", text: "Which subject would you like to teach if you return to teaching?"
      choose "Physics"
      click_on "Continue"

      expect(page).to have_css "h1", text: "Enter your date of birth"
      fill_in_date_of_birth_step
      click_on "Continue"

      expect(page).to have_css "h1", text: "Where do you live?"
      choose "UK"
      click_on "Continue"

      expect(page).to have_css "h1", text: "What is your address?"
      fill_in_address_step
      click_on "Continue"

      expect(page).to have_css "h1", text: "What is your telephone number?"
      fill_in "UK telephone number (optional)", with: "123456789"
      click_on "Continue"

      expect(page).to have_css "h1", text: "Check your answers before you continue"
      click_on "Continue"

      expect(page).to have_css "h1", text: "Read and accept the privacy policy"
      check "Accept the privacy policy"

      request_attributes = uk_candidate_request_attributes({
        type_id: RETURNING_TO_TEACHING,
        subject_taught_id: SUBJECT_PSYCHOLOGY,
        preferred_teaching_subject_id: SUBJECT_PHYSICS,
        teacher_id: "1234",
      })
      expect_sign_up_with_attributes(request_attributes)

      click_on "Complete"

      expect(page).to have_css "h1", text: "Thank you"
      expect(page).to have_css "h1", text: "Sign up complete"
    end

    scenario "with an equivalent degree" do
      visit teacher_training_adviser_steps_path

      expect(page).to have_css "h1", text: "About you"
      fill_in_identity_step
      click_on "Continue"

      expect(page).to have_css "h1", text: "Are you returning to teaching?"
      choose "No"
      click_on "Continue"

      expect(page).to have_css "h1", text: "Do you have a degree?"
      choose "I have an equivalent qualification from another country"
      click_on "Continue"

      expect(page).to have_css "h1", text: "Which stage are you interested in teaching?"
      choose "Secondary"
      click_on "Continue"

      expect(page).to have_css "h1", text: "Which subject would you like to teach?"
      select "Physics"
      click_on "Continue"

      expect(page).to have_css "h1", text: "When do you want to start your teacher training?"
      select "2022"
      click_on "Continue"

      expect(page).to have_css "h1", text: "Enter your date of birth"
      fill_in_date_of_birth_step
      click_on "Continue"

      expect(page).to have_css "h1", text: "Where do you live?"
      choose "Overseas"
      click_on "Continue"

      expect(page).to have_css "h1", text: "Which country do you live in?"
      select "Argentina"
      click_on "Continue"

      expect(page).to have_css "h1", text: "You told us you have an equivalent degree and live overseas"
      fill_in "Contact telephone number", with: "123456789"
      click_on "Continue"

      expect(page).to have_css "h1", text: "Check your answers before you continue"
      click_on "Continue"

      expect(page).to have_css "h1", text: "Read and accept the privacy policy"
      check "Accept the privacy policy"

      request_attributes = overseas_candidate_request_attributes({
        type_id: INTERESTED_IN_TEACHING,
        preferred_teaching_subject_id: SUBJECT_PHYSICS,
        degree_status_id: DEGREE_STATUS_HAS_DEGREE,
        degree_type_id: DEGREE_TYPE_EQUIVALENT,
        initial_teacher_training_year_id: TEACHER_TRAINING_YEAR_2022,
        preferred_education_phase_id: EDUCATION_PHASE_SECONDARY,
      })
      expect_sign_up_with_attributes(request_attributes)

      click_on "Complete"

      expect(page).to have_css "h1", text: "Thank you"
      expect(page).to have_css "h1", text: "Sign up complete"
    end

    scenario "studying for a degree" do
      visit teacher_training_adviser_steps_path

      expect(page).to have_css "h1", text: "About you"
      fill_in_identity_step
      click_on "Continue"

      expect(page).to have_css "h1", text: "Are you returning to teaching?"
      choose "No"
      click_on "Continue"

      expect(page).to have_css "h1", text: "Do you have a degree?"
      choose "I'm studying for a degree"
      click_on "Continue"

      expect(page).to have_css "h1", text: "In which year are you studying?"
      choose "First year"
      click_on "Continue"

      expect(page).to have_css "h1", text: "What subject is your degree?"
      select "Maths"
      click_on "Continue"

      expect(page).to have_css "h1", text: "What degree class are you predicted to get?"
      select "2:2"
      click_on "Continue"

      expect(page).to have_css "h1", text: "Which stage are you interested in teaching?"
      choose "Primary"
      click_on "Continue"

      expect(page).to have_css "h1", text: "Do you have grade 4 (C) or above in English and maths GCSEs, or equivalent?"
      choose "Yes"
      click_on "Continue"

      expect(page).to have_css "h1", text: "Do you have grade 4 (C) or above in GCSE science, or equivalent?"
      choose "Yes"
      click_on "Continue"

      expect(page).to have_css "h1", text: "When do you want to start your teacher training?"
      select "2022"
      click_on "Continue"

      expect(page).to have_css "h1", text: "Enter your date of birth"
      fill_in_date_of_birth_step
      click_on "Continue"

      expect(page).to have_css "h1", text: "Where do you live?"
      choose "Overseas"
      click_on "Continue"

      expect(page).to have_css "h1", text: "Which country do you live in?"
      select "Argentina"
      click_on "Continue"

      expect(page).to have_css "h1", text: "What is your telephone number?"
      fill_in "Overseas telephone number (optional)", with: "123456789"
      click_on "Continue"

      expect(page).to have_css "h1", text: "Check your answers before you continue"
      click_on "Continue"

      expect(page).to have_css "h1", text: "Read and accept the privacy policy"
      check "Accept the privacy policy"

      request_attributes = overseas_candidate_request_attributes({
        type_id: INTERESTED_IN_TEACHING,
        uk_degree_grade_id: UK_DEGREE_GRADE_2_2,
        degree_status_id: DEGREE_STATUS_FIRST_YEAR,
        degree_type_id: DEGREE_TYPE_DEGREE,
        initial_teacher_training_year_id: TEACHER_TRAINING_YEAR_2022,
        preferred_education_phase_id: EDUCATION_PHASE_PRIMARY,
        has_gcse_maths_and_english_id: HAS_GCSE,
        has_gcse_science_id: HAS_GCSE,
        degree_subject: "Maths",
      })
      expect_sign_up_with_attributes(request_attributes)

      click_on "Complete"

      expect(page).to have_css "h1", text: "Thank you"
      expect(page).to have_css "h1", text: "Sign up complete"
    end

    scenario "candidate tries to skip past an exit step" do
      visit teacher_training_adviser_steps_path

      expect(page).to have_css "h1", text: "About you"
      fill_in_identity_step
      click_on "Continue"

      expect(page).to have_css "h1", text: "Are you returning to teaching?"
      choose "Yes"
      click_on "Continue"

      expect(page).to have_css "h1", text: "Do you have your previous teacher reference number?"
      choose "No"
      click_on "Continue"

      expect(page).to have_css "h1", text: "Which main subject did you previously teach?"
      select "Physics"
      click_on "Continue"

      expect(page).to have_css "h1", text: "Which subject would you like to teach if you return to teaching?"
      choose "Other"
      click_on "Continue"

      # Hit dead end
      expect(page).to have_css "h1", text: "Get support"
      expect(page).to_not have_css "h1", text: "Continue"

      # Manually skip to review answers
      visit teacher_training_adviser_step_path(:review_answers)

      expect(page).to have_css "h1", text: "Check your answers before you continue"
      click_on "Continue"

      expect(page).to have_css "h1", text: "Read and accept the privacy policy"
      check "Accept the privacy policy"
      click_on "Complete"

      # Forced back to dead end
      expect(page).to have_css "h1", text: "Get support"
      expect(page).to_not have_css "h1", text: "Continue"
    end

    scenario "without a degree" do
      visit teacher_training_adviser_steps_path

      expect(page).to have_css "h1", text: "About you"
      fill_in_identity_step
      click_on "Continue"

      expect(page).to have_css "h1", text: "Are you returning to teaching?"
      choose "No"
      click_on "Continue"

      expect(page).to have_css "h1", text: "Do you have a degree?"
      choose "No"
      click_on "Continue"

      expect(page).to have_css "h1", text: "If you do not have a degree"
      expect(page).to_not have_css "h1", text: "Continue"
    end

    scenario "without science GCSEs, primary" do
      visit teacher_training_adviser_steps_path

      expect(page).to have_css "h1", text: "About you"
      fill_in_identity_step
      click_on "Continue"

      expect(page).to have_css "h1", text: "Are you returning to teaching?"
      choose "No"
      click_on "Continue"

      expect(page).to have_css "h1", text: "Do you have a degree?"
      choose "Yes"
      click_on "Continue"

      expect(page).to have_css "h1", text: "What subject is your degree?"
      select "Maths"
      click_on "Continue"

      expect(page).to have_css "h1", text: "Which class is your degree?"
      select "2:2"
      click_on "Continue"

      expect(page).to have_css "h1", text: "Which stage are you interested in teaching?"
      choose "Primary"
      click_on "Continue"

      expect(page).to have_css "h1", text: "Do you have grade 4 (C) or above in English and maths GCSEs, or equivalent?"
      choose "No"
      click_on "Continue"

      expect(page).to have_css "h1", text: "Are you planning to retake either English or maths (or both) GCSEs, or equivalent?"
      choose "Yes"
      click_on "Continue"

      expect(page).to have_css "h1", text: "Do you have grade 4 (C) or above in GCSE science, or equivalent?"
      choose "No"
      click_on "Continue"

      expect(page).to have_css "h1", text: "Are you planning to retake your science GCSE?"
      choose "No"
      click_on "Continue"

      expect(page).to have_css "h1", text: "Get the right GCSEs or equivalent qualifications"
      expect(page).to_not have_css "h1", text: "Continue"
    end

    scenario "without english/maths GCSEs, primary" do
      visit teacher_training_adviser_steps_path

      expect(page).to have_css "h1", text: "About you"
      fill_in_identity_step
      click_on "Continue"

      expect(page).to have_css "h1", text: "Are you returning to teaching?"
      choose "No"
      click_on "Continue"

      expect(page).to have_css "h1", text: "Do you have a degree?"
      choose "Yes"
      click_on "Continue"

      expect(page).to have_css "h1", text: "What subject is your degree?"
      select "Maths"
      click_on "Continue"

      expect(page).to have_css "h1", text: "Which class is your degree?"
      select "2:2"
      click_on "Continue"

      expect(page).to have_css "h1", text: "Which stage are you interested in teaching?"
      choose "Primary"
      click_on "Continue"

      expect(page).to have_css "h1", text: "Do you have grade 4 (C) or above in English and maths GCSEs, or equivalent?"
      choose "No"
      click_on "Continue"

      expect(page).to have_css "h1", text: "Are you planning to retake either English or maths (or both) GCSEs, or equivalent?"
      choose "No"
      click_on "Continue"

      expect(page).to have_css "h1", text: "Get the right GCSEs or equivalent qualifications"
      expect(page).to_not have_css "h1", text: "Continue"
    end

    scenario "without GCSEs, secondary" do
      visit teacher_training_adviser_steps_path

      expect(page).to have_css "h1", text: "About you"
      fill_in_identity_step
      click_on "Continue"

      expect(page).to have_css "h1", text: "Are you returning to teaching?"
      choose "No"
      click_on "Continue"

      expect(page).to have_css "h1", text: "Do you have a degree?"
      choose "Yes"
      click_on "Continue"

      expect(page).to have_css "h1", text: "What subject is your degree?"
      select "Maths"
      click_on "Continue"

      expect(page).to have_css "h1", text: "Which class is your degree?"
      select "2:2"
      click_on "Continue"

      expect(page).to have_css "h1", text: "Which stage are you interested in teaching?"
      choose "Secondary"
      click_on "Continue"

      expect(page).to have_css "h1", text: "Do you have grade 4 (C) or above in English and maths GCSEs, or equivalent?"
      choose "No"
      click_on "Continue"

      expect(page).to have_css "h1", text: "Are you planning to retake either English or maths (or both) GCSEs, or equivalent?"
      choose "No"
      click_on "Continue"

      expect(page).to have_css "h1", text: "Get the right GCSEs or equivalent qualifications"
      expect(page).to_not have_css "h1", text: "Continue"
    end

    scenario "can't find subject like to teach" do
      visit teacher_training_adviser_steps_path

      expect(page).to have_css "h1", text: "About you"
      fill_in_identity_step
      click_on "Continue"

      expect(page).to have_css "h1", text: "Are you returning to teaching?"
      choose "Yes"
      click_on "Continue"

      expect(page).to have_css "h1", text: "Do you have your previous teacher reference number?"
      choose "No"
      click_on "Continue"

      expect(page).to have_css "h1", text: "Which main subject did you previously teach?"
      select "Physics"
      click_on "Continue"

      expect(page).to have_css "h1", text: "Which subject would you like to teach if you return to teaching?"
      choose "Other"
      click_on "Continue"

      expect(page).to have_css "h1", text: "Get support"
      expect(page).to_not have_css "h1", text: "Continue"
    end
  end

  context "an existing candidate" do
    let(:valid_code) { "123456" }
    let(:invalid_code) { "111111" }
    let(:existing_candidate) do
      GetIntoTeachingApiClient::TeacherTrainingAdviserSignUp.new(
        preferredEducationPhaseId: TeacherTrainingAdviser::Steps::StageInterestedTeaching::OPTIONS[:secondary],
        addressLine1: "7 Main Street",
        addressCity: "Manchester",
        addressPostcode: "TE7 1NG",
        dateOfBirth: Date.new(1999, 4, 27),
        telephone: "123456789",
        teacherId: "12345",
      )
    end

    before do
      allow_any_instance_of(GetIntoTeachingApiClient::CandidatesApi).to \
        receive(:create_candidate_access_token)
      allow_any_instance_of(GetIntoTeachingApiClient::TeacherTrainingAdviserApi).to \
        receive(:exchange_access_token_for_teacher_training_adviser_sign_up)
        .with(valid_code, anything)
        .and_return(existing_candidate)
      allow_any_instance_of(GetIntoTeachingApiClient::TeacherTrainingAdviserApi).to \
        receive(:exchange_access_token_for_teacher_training_adviser_sign_up)
        .with(invalid_code, anything)
        .and_raise(GetIntoTeachingApiClient::ApiError)
    end

    scenario "matchback" do
      visit teacher_training_adviser_steps_path

      expect(page).to have_css "h1", text: "About you"
      fill_in_identity_step
      click_on "Continue"

      expect(page).to have_css "h1", text: "Verify your email address"
      expect(page).to have_text "Enter the verification code sent to john@doe.com"
      click_on "resend verification"

      expect(page).to have_text "We've sent you another email."
      fill_in "wizard-steps-authenticate-timed-one-time-password-field", with: invalid_code
      click_on "Continue"

      expect(page).to have_text "Please enter the latest verification code sent to your email address"
      fill_in "wizard-steps-authenticate-timed-one-time-password-field-error", with: valid_code
      click_on "Continue"

      expect(page).to have_css "h1", text: "Are you returning to teaching?"
      choose "No"
      click_on "Continue"

      expect(page).to have_css "h1", text: "Do you have a degree?"
      choose "I have an equivalent qualification from another country"
      click_on "Continue"

      expect(page).to have_css "h1", text: "Which stage are you interested in teaching?"
      expect(find_field("Secondary")).to be_checked
      click_on "Continue"

      expect(page).to have_css "h1", text: "Which subject would you like to teach?"
      select "Physics"
      click_on "Continue"

      expect(page).to have_css "h1", text: "When do you want to start your teacher training?"
      select "2022"
      click_on "Continue"

      expect(page).to have_css "h1", text: "Enter your date of birth"
      expect(find_field("Day").value).to eq("27")
      expect(find_field("Month").value).to eq("4")
      expect(find_field("Year").value).to eq("1999")
      click_on "Continue"

      expect(page).to have_css "h1", text: "Where do you live?"
      choose "UK"
      click_on "Continue"

      expect(page).to have_css "h1", text: "What is your address?"
      expect(find_field("Address line 1").value).to eq("7 Main Street")
      expect(find_field("Town or City").value).to eq("Manchester")
      expect(find_field("Postcode").value).to eq("TE7 1NG")
      click_on "Continue"

      expect(page).to have_css "h1", text: "You told us you have an equivalent degree and live in the United Kingdom"
      expect(find_field("Contact telephone number").value).to eq("123456789")
      select_first_option "Select your preferred day and time for a callback"
      click_on "Continue"

      expect(page).to have_css "h1", text: "Check your answers before you continue"
      click_on "Continue"

      expect(page).to have_css "h1", text: "Read and accept the privacy policy"
      check "Accept the privacy policy"

      request_attributes = uk_candidate_request_attributes({
        preferred_education_phase_id: EDUCATION_PHASE_SECONDARY,
        preferred_teaching_subject_id: SUBJECT_PHYSICS,
        degree_status_id: DEGREE_STATUS_HAS_DEGREE,
        degree_type_id: DEGREE_TYPE_EQUIVALENT,
        initial_teacher_training_year_id: TEACHER_TRAINING_YEAR_2022,
        phone_call_scheduled_at: "2020-08-19T08:00:00.000Z",
        date_of_birth: "1999-04-27",
        address_line1: "7 Main Street",
        address_line2: nil,
        address_city: "Manchester",
        address_postcode: "TE7 1NG",
      })
      expect_sign_up_with_attributes(request_attributes)

      click_on "Complete"

      expect(page).to have_css "h1", text: "Thank you"
      expect(page).to have_css "h1", text: "Sign up complete"
    end

    scenario "skipping pre-filled optional steps" do
      visit teacher_training_adviser_steps_path

      expect(page).to have_css "h1", text: "About you"
      fill_in_identity_step
      click_on "Continue"

      expect(page).to have_css "h1", text: "Verify your email address"
      fill_in "wizard-steps-authenticate-timed-one-time-password-field", with: valid_code
      click_on "Continue"

      expect(page).to have_css "h1", text: "Are you returning to teaching?"
      choose "Yes"
      click_on "Continue"

      expect(page).to_not have_css "h1", text: "Do you have your previous teacher reference number?"
      expect(page).to_not have_css "h1", text: "What is your previous teacher reference number?"

      expect(page).to have_css "h1", text: "Which main subject did you previously teach?"
      select "Psychology"
      click_on "Continue"

      expect(page).to have_css "h1", text: "Which subject would you like to teach if you return to teaching?"
      choose "Physics"
      click_on "Continue"

      expect(page).to have_css "h1", text: "Enter your date of birth"
      expect(find_field("Day").value).to eq("27")
      expect(find_field("Month").value).to eq("4")
      expect(find_field("Year").value).to eq("1999")
      click_on "Continue"

      expect(page).to have_css "h1", text: "Where do you live?"
      choose "UK"
      click_on "Continue"

      expect(page).to have_css "h1", text: "What is your address?"
      expect(find_field("Address line 1").value).to eq("7 Main Street")
      expect(find_field("Town or City").value).to eq("Manchester")
      expect(find_field("Postcode").value).to eq("TE7 1NG")
      click_on "Continue"

      expect(page).to_not have_css "h1", text: "What is your telephone number?"

      expect(page).to have_css "h1", text: "Check your answers before you continue"
      click_on "Continue"

      expect(page).to have_css "h1", text: "Read and accept the privacy policy"
      check "Accept the privacy policy"

      request_attributes = uk_candidate_request_attributes({
        subject_taught_id: SUBJECT_PSYCHOLOGY,
        preferred_teaching_subject_id: SUBJECT_PHYSICS,
        date_of_birth: "1999-04-27",
        address_line1: "7 Main Street",
        address_line2: nil,
        address_city: "Manchester",
        address_postcode: "TE7 1NG",
        teacher_id: "12345",
      })
      expect_sign_up_with_attributes(request_attributes)

      click_on "Complete"

      expect(page).to have_css "h1", text: "Thank you"
      expect(page).to have_css "h1", text: "Sign up complete"
    end
  end

  def fill_in_identity_step
    fill_in "First name", with: "John"
    fill_in "Last name", with: "Doe"
    fill_in "Email address", with: "john@doe.com"
  end

  def fill_in_date_of_birth_step
    fill_in "Day", with: "24"
    fill_in "Month", with: "03"
    fill_in "Year", with: "1966"
  end

  def fill_in_address_step
    fill_in "Address line 1", with: "7"
    fill_in "Address line 2 (optional)", with: "Main Street"
    fill_in "Town or City", with: "Edinburgh"
    fill_in "Postcode", with: "EH12 8JF"
  end

  def select_first_option(field_label)
    find_field(field_label).first("option").select_option
  end

  def expect_sign_up_with_attributes(request_attributes)
    expect_any_instance_of(GetIntoTeachingApiClient::TeacherTrainingAdviserApi).to \
      receive(:sign_up_teacher_training_adviser_candidate)
      .with(having_attributes(request_attributes))
      .once
  end

  def uk_candidate_request_attributes(attributes = {})
    {
      email: "john@doe.com",
      first_name: "John",
      last_name: "Doe",
      date_of_birth: "1966-03-24",
      address_line1: "7",
      address_line2: "Main Street",
      address_city: "Edinburgh",
      address_postcode: "EH12 8JF",
      country_id: "72f5c2e6-74f9-e811-a97a-000d3a2760f2",
      accepted_policy_id: "0a203956-e935-ea11-a813-000d3a44a8e9",
    }
    .merge(shared_request_attributes)
    .merge(attributes)
  end

  def overseas_candidate_request_attributes(attributes = {})
    {
      country_id: "09f4c2e6-74f9-e811-a97a-000d3a2760f2",
    }
    .merge(shared_request_attributes)
    .merge(attributes)
  end

  def shared_request_attributes
    {
      email: "john@doe.com",
      first_name: "John",
      last_name: "Doe",
      date_of_birth: "1966-03-24",
      telephone: "123456789",
    }
  end
end
