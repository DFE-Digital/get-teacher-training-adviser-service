require 'rails_helper'

RSpec.describe DateOfBirth do
  let(:dob) { build(:date_of_birth) }


  describe "validation" do
    

    context "with required attributes" do
      it "is valid" do
        expect(dob).to be_valid
      end
    end
  end
end
