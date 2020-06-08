require "rails_helper"

RSpec.feature "View pages", type: :feature do
  scenario "Navigate to home" do
    visit "/home"

    expect(page).to have_text("Sign up to talk to a teaching adviser\n")
  end
end
