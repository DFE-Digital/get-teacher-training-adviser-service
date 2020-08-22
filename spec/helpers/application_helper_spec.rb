require "rails_helper"

RSpec.describe ApplicationHelper, type: :helper do
  describe "#govuk_form_for" do
    it "renders a form with GOV.UK form builder" do
      expect(govuk_form_for(StubModel.new, url: "http://test.com") {}).to eq(
        "<form class=\"new_stub_model\" id=\"new_stub_model\" novalidate=\"novalidate\" "\
        "action=\"http://test.com\" accept-charset=\"UTF-8\" method=\"post\"></form>",
      )
    end
  end

  describe "#back_link" do
    it "renders a back link with GOV.UK class names" do
      expect(back_link).to eq("<a class=\"govuk-back-link\" href=\"javascript:history.back()\">Back</a>")
    end
  end

  describe "#link_to_change_answer" do
    it "returns a link to the sign up step" do
      expect(link_to_change_answer(TeacherTrainingAdviser::Steps::Identity)).to eq(
        "<a href=\"/teacher_training_adviser/sign_up/identity\">Change</a>",
      )
    end
  end

  class StubModel
    include ActiveModel::Model
  end
end
