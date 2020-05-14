require 'rails_helper'

RSpec.describe 'Identity' do
  let(:identity) { build(:identity) }
  let(:no_name) { build(:identity, first_name: "") }

  describe "validation" do

    context "without required attributes" do
      it "should be invalid" do
        expect(no_name).to_not be_valid
      end

      it "should return error messages" do
        no_name.valid?
        expect(no_name.errors[:first_name]).to eq ["can't be blank"]
      end
    end

    context "with invalid email addresses" do
      ['test.com', 'test@@test.com', 'FFFF', 'test@test', 'test@test.'].each do |invalid_email_address|
        let(:instance) { build(:identity, email_address: invalid_email_address) }
        it "should not be valid" do
          expect(instance).to_not be_valid
        end
      end
    end

    context "with valid email addresses" do
      ['test@example.com', 'testymctest@gmail.com', 'test%.mctest@domain.co.uk'].each do |valid_email_address|
        let(:instance) { build(:identity, email_address: valid_email_address) }
        it "should be valid" do
          expect(instance).to be_valid
        end
      end
    end

  end

  describe '#next_step' do
    it "should return the next step" do
      expect(identity.next_step).to eq('returning_teacher')
    end
  end

end