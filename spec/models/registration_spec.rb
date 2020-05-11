require 'rails_helper'

RSpec.describe 'Registration' do
  let(:registration) { build(:registration) }
  let(:no_email_stage0) { build(:registration, :stage0, email_address: "", returning_to_teaching: "") }
  let(:no_name_stage0) { build(:registration, :stage0, first_name: "") }
  let(:no_email_stage1) { build(:registration, :stage1, email_address: "") }
  subject(:no_email_stage) { no_email_stage0 }

  describe "validation" do

    context "without required attributes at relevant stage" do
      it "should be invalid" do
        expect(no_email_stage0).to_not be_valid
        expect(no_name_stage0).to_not be_valid
      end

      it "should return error messages" do
        no_email_stage0.valid?
        expect(no_email_stage0.errors.messages[:email_address]).to eq ["can't be blank"]
      end
    end

    context "without required attributes at last stage" do
      it "should be invalid" do
        expect(no_email_stage1).to_not be_valid 
      end
    end

   
  end
  
end