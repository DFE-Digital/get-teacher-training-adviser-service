require "rails_helper"

RSpec.feature "View pages", type: :feature do
  scenario "Navigates to home page" do
    visit "/home"
    expect(page).to have_text("Sign up to get an adviser\n")
  end
end
