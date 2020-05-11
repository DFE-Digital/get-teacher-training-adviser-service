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
        expect(no_email_stage0.errors.messages[:email_address]).to eq ["is invalid"]
      end
    end

    context "without required attributes at last stage" do
      it "should be invalid" do
        expect(no_email_stage1).to_not be_valid 
      end
    end

    context "with invalid email addresses" do
      ['test.com', 'test@@test.com', 'FFFF', 'test@test', 'test@test.'].each do |invalid_email_address|
        let(:instance) { build(:registration, email_address: invalid_email_address) }
        it " should not be valid" do
          expect(instance).to_not be_valid
        end
      end
    end

    context "with valid email addresses" do
      ['test@example.com(opens in new tab)', 'testymctest@gmail.com(opens in new tab)', 'test%.mctest@domain.co.uk'].each do |valid_email_address|
        let(:instance) { build(:registration, email_address: valid_email_address) }
        it " should be valid" do
          expect(instance).to be_valid
        end
      end
    end

   
  end
  
end