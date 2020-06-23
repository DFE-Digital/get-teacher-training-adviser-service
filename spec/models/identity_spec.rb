require 'rails_helper'

RSpec.describe Identity do
  let(:identity) { build(:identity) }
  let(:no_name) { build(:identity, first_name: "") }

  describe "validation" do

    context "without required attributes" do
      it "is invalid" do
        expect(no_name).to_not be_valid
      end

    end

    context "with invalid email addresses" do
      ['test.com', 'FFFF', 'test@test.'].each do |invalid_email_address|
        it "is not valid" do
          expect(build(:identity, email_address: invalid_email_address)).to_not be_valid
        end
      end
    end

    context "with valid email addresses" do
      ['test@example.com', 'testymctest@gmail.com', 'test%.mctest@domain.co.uk'].each do |valid_email_address|
        it "is valid" do
          expect(build(:identity, email_address: valid_email_address)).to be_valid
        end
      end
    end

  end

  describe '#next_step' do
    it "returns the next step" do
      expect(identity.next_step).to eq('returning_teacher')
    end
  end

end