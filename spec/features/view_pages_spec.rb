require "rails_helper"

RSpec.feature "View pages", type: :feature do
  scenario "Navigates to home page" do
    visit "/home"
    expect(page).to have_text("Get an adviser\n")
  end
end
