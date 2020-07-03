require "rails_helper"

RSpec.describe SessionHelper, :vcr, type: :helper do
  describe "#show_session" do
    context "with a session value" do
      it "returns the value capitalized" do
        session[:registration] = { "identity" => "me" }
        expect(show_session("identity")).to eq("Me")
      end
    end
    context "with uk as the value" do
      it "returns the value capitalised" do
        session[:registration] = { "identity" => "uk" }
        expect(show_session("identity")).to eq("UK")
        session[:registration] = { "identity" => "UK" }
        expect(show_session("identity")).to eq("UK")
        session[:registration] = { "identity" => "Uk" }
        expect(show_session("identity")).to eq("UK")
      end
    end
    context "with missing sesson value" do
      it "returns nil" do
        session[:registration] = {}
        expect(show_session("identity")).to eq(nil)
      end
    end
  end

  describe "#show_link" do
    it "returns a link to the registration step" do
      expect(show_link("identity")).to eq("<a href='#{new_registration_path('identity')}'>Change</a>".html_safe)
    end
  end

  describe "#show_dob" do
    it "returns the session date_of_birth value" do
      session[:registration] = { "date_of_birth" => Date.new(2000, 10, 1) }
      expect(show_dob).to eq("01 10 2000")
    end
  end

  describe "#show_callback_date" do
    it "returns the session callback_date value" do
      session[:registration] = { "callback_date" => Date.new(2000, 10, 1) }
      expect(show_callback_date).to eq("01 10 2000")
    end
  end

  describe "#show_callback_time" do
    it "returns the session callback_date value" do
      session[:registration] = { "callback_time" => "9:00pm" }
      expect(show_callback_time).to eq("9:00pm")
    end
  end

  describe "#show_uk_address" do
    it "returns the session address values" do
      session[:registration] = { "address_line_1" => "22",
        "address_line_2" => "acacia avenue",
        "town_city" => "bradford",
        "postcode" => "tr1 1uf"  }
      expect(show_uk_address).to eq("22<br />acacia avenue<br />bradford<br />tr1 1uf")
    end
  end

  describe "#show_name" do
    it "returns the session name value" do
      session[:registration] = { "first_name" => "joe",
        "last_name" => "bloggs"  }
      expect(show_name).to eq("Joe Bloggs")
    end
  end

  describe "#show_email" do
    it "returns the session email value" do
      session[:registration] = {
        "email_address" => "jo@bloggs.com",
      }
      expect(show_email).to eq("jo@bloggs.com")
    end
  end

  describe "#show_phone" do
    it "returns the session telephone value" do
      session[:registration] = {
        "telephone_number" => "1234567",
      }
      expect(show_phone).to eq("1234567")
    end
  end

  describe "#show_country" do
    it "returns the session country_code name" do
      session[:registration] = {
        "country_code" => "GB",
      }
      expect(show_country).to eq("United Kingdom of Great Britain and Northern Ireland")
    end
  end

  describe "#show_true_or_false" do
    it "converts bools to yes or no" do
      session[:registration] = {
        "retaking_science" => true,
      }
      expect(show_true_or_false("retaking_science")).to eq("Yes")
      session[:registration] = {
        "retaking_science" => false,
      }
      expect(show_true_or_false("retaking_science")).to eq("No")
    end
  end

  describe "#show_subject" do
    it "returns the session 'question' name" do
      session[:registration] = {
        "prev_subject" => "6b793433-cd1f-e911-a979-000d3a20838a",
      }
      expect(show_subject("prev_subject")).to eq("Art")
    end
  end
end
