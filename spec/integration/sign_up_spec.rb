require "rails_helper"

RSpec.describe "Sign up", :integration, type: :feature, js: true do
  before do
    config_capybara

    visit teacher_training_adviser_steps_path
    click_link "Accept all cookies"
  end

  around do |example|
    WebMock.enable_net_connect!
    example.run
    WebMock.disable_net_connect!(allow_localhost: true)
  end

  it "Full journey as a new candidate" do
    sign_up(rand_first_name, rand_last_name, rand_email)
  end

  it "Full journey as an existing candidate" do
    email = "ttauser@mailsac.com"
    submit_personal_details(rand_first_name, rand_last_name, email)

    submit_code(email)

    expect(page).to have_text("You have already signed up to this service")
  end

  def sign_up(first_name, last_name, email)
    submit_personal_details(first_name, last_name, email)
    submit_label_step("Yes", :returning_teacher)
    submit_label_step("Yes", :has_teacher_id)
    submit_previous_teacher_id_step("12345")
    submit_select_step("Maths", :subject_taught)
    submit_label_step("Physics", :subject_like_to_teach)
    submit_date_of_birth_step(Date.new(1974, 3, 16))
    submit_label_step("UK", :uk_or_overseas)
    submit_uk_address_step(
      address_line1: "5 Main Street",
      address_line2: "Dalkeith",
      town_city: "Edinburgh",
      postcode: "TE7 5TR",
    )
    submit_uk_telephone_step("123456789")
    submit_review_answers_step
    submit_label_step(
      "Accept the privacy policy",
      :accept_privacy_policy,
      button_text: "Complete",
    )
    expect(page).to have_text("Sign up complete")
  end
end
