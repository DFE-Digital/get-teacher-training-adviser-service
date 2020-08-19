require "rails_helper"

RSpec.describe RegistrationsController, type: :request do
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
    context "with a valid step name and payload" do
      it "returns a success response" do
        params = { identity: { email: "email@address.com", first_name: "first", last_name: "last" } }
        post registrations_path(identity.step_name), params: params
        expect(response).to redirect_to(new_registration_path(identity.next_step))
      end
    end

    context "with an invalid step name" do
      it "raises an error" do
        expect {
          post registrations_path(invalid_step)
        }.to raise_error(StepFactory::NameNotFoundError)
      end
    end

    context "with invalid registration data" do
      it "redirects to new_registration_path" do
        params = { identity: { email: "invalid-email.com" } }
        post registrations_path(identity.step_name), params: params
        expect(response).to_not redirect_to(new_registration_path(identity.next_step))
      end
    end
  end
end
