require 'rails_helper'

RSpec.describe SessionHelper, type: :helper do
  describe "#show_session" do
    context "with a session value" do
      it "returns the value titleized" do
        session[:registration] = {'identity' => 'me' }
        expect(show_session('identity')).to eq('Me')
      end
    end
    context "with missing sesson value" do
      it "returns nil" do
        session[:registration] = {}
        expect(show_session('identity')).to eq(nil)
      end
    end
  end
  
  describe "#show_link" do
    it "returns a link to the registration step" do
      expect(show_link('identity')).to eq("<a href='#{ new_registration_path('identity') }'>Change</a>".html_safe)
    end
  end

  describe "#show_dob" do
    it "returns the session date_of_birth value" do
      session[:registration] = { 'date_of_birth' => '2000-10-1'}
      expect(show_dob).to eq("Oct 01, 2000")
    end
  end

  describe "#show_uk_address" do
    it "returns the session address values" do
      session[:registration] = { 'address_line_1' => "22",
        'address_line_2' => 'acacia avenue',
        'town_city' => 'bradford',
        'postcode' => 'tr1 1uf'
      }
      expect(show_uk_address).to eq("22<br />acacia avenue<br />bradford<br />tr1 1uf")
    end
  end

  describe "show_name_and_email" do
    it "returns the session name and email values" do
      session[:registration] = { 'first_name' => 'joe',
        'last_name' => 'bloggs',
        'email_address' => 'jo@bloggs.com'
      }
      expect(show_name_and_email).to eq("Joe Bloggs, jo@bloggs.com")
    end
  end
end
  
