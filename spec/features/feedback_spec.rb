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
end
