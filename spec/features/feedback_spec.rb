require "rails_helper"

RSpec.feature "Feedback", type: :feature do
  scenario "submitting feedback" do
    visit root_path

    within ".govuk-phase-banner" do
      click_link "feedback"
    end

    choose "No"
    fill_in "Give details", with: "I didn't like it"
    choose "Satisfied"
    fill_in "How could we improve the service? (optional)", with: "You could to better"

    click_on "Submit feedback"

    expect(page).to have_text "Thank you"
  end

  scenario "a bot submitting feedback (filling in the honeypot)" do
    visit new_teacher_training_adviser_feedback_path

    choose "Yes"
    choose "Satisfied"
    fill_in "If you are a human, ignore this field", with: "i-am-a-bot"

    click_on "Submit feedback"

    expect(page.status_code).to eq(200)
    expect(page.body).to eq("")
  end
end
