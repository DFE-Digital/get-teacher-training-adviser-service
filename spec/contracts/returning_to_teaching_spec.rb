require "rails_helper"

RSpec.feature "Returning to teaching", type: :feature, vcr: false do
  before do
    setup_data
    setup_contract

    visit teacher_training_adviser_steps_path

    submit_identity_step(candidate_identity)
    submit_choice_step("Yes", :returning_teacher)
  end

  around do |example|
    travel_to(DateTime.parse(state["utcNow"]))
    VCR.turned_off { example.run }
    travel_back
  end

  context "with a new candidate" do
    let(:candidate_identity) { new_candidate_identity }

    scenario "has a teacher reference number, is in the UK and provides a telephone" do
      submit_choice_step("Yes", :has_teacher_id)
      submit_previous_teacher_id_step("12345")
      submit_select_step("Maths", :subject_taught)
      submit_choice_step("Physics", :subject_like_to_teach)
      submit_date_of_birth_step(Date.new(1974, 3, 16))
      submit_choice_step("UK", :uk_or_overseas)
      submit_uk_address_step(
        address_line1: "5 Main Street",
        address_line2: "Dalkeith",
        town_city: "Edinburgh",
        postcode: "TE7 5TR",
      )
      submit_uk_telephone_step("123456789")
      submit_review_answers_step
      submit_privacy_policy_step
    end
  end
end
