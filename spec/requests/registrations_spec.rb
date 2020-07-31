require "rails_helper"

RSpec.describe RegistrationsController, :vcr, type: :request do
  let(:identity) { build(:identity) }
  let(:invalid_step) { "invalid_entity" }
  let(:get_invalid_step_url) { get new_registration_path(invalid_step) }

  describe "get /registrations/:step_name" do
    context "with a valid step name" do
      it "returns a success response" do
        get new_registration_path(identity.step_name)
        expect(response).to have_http_status(200)
      end
    end

    context "with an invalid step name" do
      it "redirects to root" do
        expect(get_invalid_step_url).to redirect_to :root
      end
    end
  end

  describe "post /registrations/:step_name" do
    context "with a valid step name" do
      it "returns a success response" do
        post registrations_path(identity.step_name)
        expect(response).to have_http_status(200)
      end
    end

    context "with an invalid step name" do
      it "raises an error" do
        expect {
          post registrations_path(invalid_step)
        }.to raise_error(StepFactory::NameNotFoundError)
      end
    end
  end
end
