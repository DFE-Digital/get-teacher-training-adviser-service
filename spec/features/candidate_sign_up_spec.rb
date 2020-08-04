require "rails_helper"

RSpec.feature "Sign up for a Teacher Training Advisor", :vcr, type: :feature do
  # group by Persona
  personas = {}

  Dir.glob(".tmp/contracts/*_html.json") do |filename|
    data = JSON.parse(File.read(filename))
    data["filename"] = File.basename(filename)

    # add the candidate to the correct Persona list
    personas[data["Persona"]] = personas[data["Persona"]] || []
    personas[data["Persona"]].push data
  end

  personas.each do |persona, candidates|
    feature "as a #{persona}" do
      candidates.each do |candidate|

        scenario "can complete the process with details defined in [#{candidate['filename']}]" do
          start_sign_up_wizard

          enter_personal_information candidate["First Name"], candidate["Surname"], candidate["Email"]

          enter_returner_details candidate

          unless candidate["Returner"] == "Yes"
            enter_degree_details candidate
            enter_teaching_stage_details candidate["Stage of Interest"]
            enter_gcse_qualification_details candidate
            enter_training_start_details candidate
          end

          enter_date_of_birth candidate["DOB (Year)"], candidate["DOB (Month)"], candidate["DOB (Date)"]

          enter_where_lives candidate

          check_answers candidate

          accept_the_privacy_policy
        end
      end
    end
  end

  # step definitions

  def start_sign_up_wizard
    visit "/"

    expect(page).to have_text "Sign up to talk to a teacher training adviser"

    click_link "Start now"
  end

  def enter_personal_information(first_name, surname, email)
    expect(page).to have_text "About you"

    fill_in "First name", with: first_name
    fill_in "Surname", with: surname
    fill_in "Email address", with: email

    click_button "Continue"
  end

  def enter_returner_details(candidate)
    answer_returning_to_teaching_query candidate["Returner"]

    if candidate["Returner"] == "Yes"
      answer_teacher_reference_number_query candidate["Has previous teacher reference number"]
      enter_teacher_reference_number candidate["Teacher Ref Number (TRN)"] if candidate["Has previous teacher reference number"] == "Yes"

      enter_previous_teaching_subject candidate["Previous main subject"]

      enter_subject_to_teach candidate["Return to subject"]
    end
  end

  def answer_returning_to_teaching_query(returning)
    expect(page).to have_text "Are you returning to teaching?"

    choose returning

    click_button "Continue"
  end

  def answer_teacher_reference_number_query(has_trn)
    expect(page).to have_text "Do you have your previous teacher reference number?"

    choose has_trn

    click_button "Continue"
  end

  def enter_teacher_reference_number(trn)
    expect(page).to have_text "What is your previous teacher reference number?"

    fill_in "Teacher reference number (optional).", with: trn

    click_button "Continue"
  end

  def enter_previous_teaching_subject(subject_id)
    expect(page).to have_text "Which main subject did you previously teach?"

    select subject_id, from: "Which main subject did you previously teach?"

    click_button "Continue"
  end

  def enter_subject_to_teach(subject_id)
    expect(page).to have_text "Which subject would you like to teach if you return to teaching?"

    choose subject_id

    click_button "Continue"
  end

  def enter_degree_details(candidate)
    answer_has_degree_query candidate["Degree"]

    if candidate["Degree"] == "Yes"
      enter_degree_subject candidate["Degree subject"]
      enter_degree_class candidate["Degree class"]
    end
  end

  def answer_has_degree_query(has_degree)
    expect(page).to have_text "Do you have a degree?"

    choose has_degree

    click_button "Continue"
  end

  def enter_degree_subject(degree_subject)
    expect(page).to have_text "What subject is your degree?"

    select degree_subject, from: "What subject is your degree?"

    click_button "Continue"
  end

  def enter_degree_class(degree_class)
    expect(page).to have_text "Which class is your degree?"

    select degree_class, from: "Which class is your degree?"

    click_button "Continue"
  end

  def enter_teaching_stage_details(teaching_stage)
    expect(page).to have_text "Which stage are you interested in teaching?"

    choose teaching_stage

    click_button "Continue"
  end

  def enter_gcse_qualification_details(candidate)
    enter_gcse_maths_english_details candidate
    enter_gcse_science_details candidate
  end

  def enter_gcse_maths_english_details(candidate)
    answer_gcse_maths_english_query candidate["Grade 4 English and Maths"]
  end

  def answer_gcse_maths_english_query(has_maths_english)
    expect(page).to have_text "Do you have grade 4 (C) or above in English and maths GCSEs, or equivalent?"

    choose has_maths_english

    click_button "Continue"
  end

  def enter_gcse_science_details(candidate)
    answer_gcse_science_query candidate["Grade 4 Science"]
  end

  def answer_gcse_science_query(has_science)
    expect(page).to have_text "Do you have grade 4 (C) or above in GCSE science, or equivalent?"

    choose has_science

    click_button "Continue"
  end

  def enter_training_start_details(candidate)
    expect(page).to have_text "When do you want to start your teacher training?"

    select candidate["Desired start"], from: "When do you want to start your teacher training?"

    click_button "Continue"
  end

  def enter_date_of_birth(year, month, date)
    expect(page).to have_text "Enter your date of birth"

    fill_in "Day", with: date
    fill_in "Month", with: month
    fill_in "Year", with: year

    click_button "Continue"
  end

  def enter_where_lives(candidate)
    enter_uk_or_overseas candidate["Where live"]
    enter_uk_address candidate                  if candidate["Where live"] == "UK"
    enter_overseas_address candidate            if candidate["Where live"] == "Overseas"
  end

  def enter_uk_or_overseas(uk_or_overseas)
    expect(page).to have_text "Where do you live?"

    choose uk_or_overseas

    click_button "Continue"
  end

  def enter_uk_address(candidate)
    enter_address candidate["Address line 1"], candidate["Address line 2"], candidate["Town or city"], candidate["Postcode"]
    enter_uk_telephone candidate["Telephone"]
  end

  def enter_overseas_address(candidate)
    choose_country candidate["Country"]
    enter_overseas_telephone candidate["Telephone"]
  end

  def enter_address(address_line1, address_line2, city, postcode)
    expect(page).to have_text "What is your address?"

    fill_in "Address line 1 *", with: address_line1
    fill_in "Address line 2", with: address_line2
    fill_in "Town or City *", with: city
    fill_in "Postcode *", with: postcode

    click_button "Continue"
  end

  def enter_uk_telephone(telephone)
    expect(page).to have_text "What is your telephone number?"

    fill_in "UK telephone number (optional)", with: telephone

    click_button "Continue"
  end

  def choose_country(country)
    expect(page).to have_text "Which country do you live in?"

    select country, from: "Which country do you live in?"

    click_button "Continue"
  end

  def enter_overseas_telephone(telephone)
    expect(page).to have_text "What is your telephone number?"

    fill_in "Overseas telephone number (optional)", with: telephone

    click_button "Continue"
  end

  def check_answers(candidate)
    expect(page).to have_text "Check your answers before you continue"

    expect(page).to have_text "Name #{candidate['First Name']} #{candidate['Surname']}"
    expect(page).to have_text "Date of birth #{candidate['DOB (Date)']} #{candidate['DOB (Month)']} #{candidate['DOB (Year)']}"
    expect(page).to have_text "Email\n#{candidate['Email']}"
    expect(page).to have_text "Are you returning to teaching? #{candidate['Returner']}"

    if candidate["Returner"] == "Yes"
      expect(page).to have_text "What is your previous teacher reference number? #{candidate['Teacher Ref Number (TRN)']}"
      expect(page).to have_text "Which main subject did you previously teach? #{candidate['Previous main subject']}"
      expect(page).to have_text "Which subject would you like to teach if you return to teaching?\n#{candidate['Return to subject']}"
    end

    expect(page).to have_text "Where do you live? #{candidate['Where live']}"
    if candidate["Where live"] == "UK"
      expect(page).to have_text "Address #{candidate['Address line 1']}#{candidate['Address line 2']}#{candidate['Town or city']}#{candidate['Postcode']}"
      expect(page).to have_text "Telephone #{candidate['Telephone']}"
    else
      expect(page).to have_text "Which country do you live in?\n#{candidate['Country']}"
      expect(page).to have_text "Telephone\n#{candidate['Telephone']}"
    end

    click_button "Continue"
  end

  def accept_the_privacy_policy
    expect(page).to have_text "Read and accept the privacy policy"

    check "Accept the privacy policy"

    # click_button "Continue"
  end
end
