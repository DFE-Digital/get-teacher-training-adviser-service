require 'rails_helper'

RSpec.describe DateOfBirth do
  subject(:date_of_birth) { DateOfBirth.new({'date_of_birth(3i)' => '1', 'date_of_birth(2i)' => '12', 'date_of_birth(1i)' => '2001'}) }
  subject(:invalid_month) { DateOfBirth.new({'date_of_birth(3i)' => '1', 'date_of_birth(2i)' => '13', 'date_of_birth(1i)' => '2001'}) }
  subject(:invalid_day) { DateOfBirth.new({'date_of_birth(3i)' => '32', 'date_of_birth(2i)' => '12', 'date_of_birth(1i)' => '2001'}) }
  subject(:invalid_year) { DateOfBirth.new({'date_of_birth(3i)' => '32', 'date_of_birth(2i)' => '12', 'date_of_birth(1i)' => Time.now.year + 1 }) }

  describe "validation" do
    context "with required attributes" do
      it "is valid" do
        expect(date_of_birth).to be_valid
      end
    end

    context "with invalid attributes" do
      it "is not valid" do
        expect(invalid_day).not_to be_valid
        expect(invalid_month).not_to be_valid
        expect(invalid_year).not_to be_valid
      end
    end
  end
end
