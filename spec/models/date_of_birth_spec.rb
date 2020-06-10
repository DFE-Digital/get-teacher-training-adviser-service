require 'rails_helper'

RSpec.describe DateOfBirth do
  let(:date_of_birth) { described_class.new({'date_of_birth(3i)' => '1', 'date_of_birth(2i)' => '12', 'date_of_birth(1i)' => '2001'}) }
  let(:invalid_month) { described_class.new({'date_of_birth(3i)' => '1', 'date_of_birth(2i)' => '13', 'date_of_birth(1i)' => '2001'}) }
  let(:invalid_day) { described_class.new({'date_of_birth(3i)' => '32', 'date_of_birth(2i)' => '12', 'date_of_birth(1i)' => '2001'}) }
  let(:invalid_year) { described_class.new({'date_of_birth(3i)' => '32', 'date_of_birth(2i)' => '12', 'date_of_birth(1i)' => Time.now.year + 1 }) }
  let(:impossible_date) { described_class.new({'date_of_birth(3i)' => '31', 'date_of_birth(2i)' => '2', 'date_of_birth(1i)' => Time.now.year }) }
  let(:too_young)  { described_class.new({'date_of_birth(3i)' => '1', 'date_of_birth(2i)' => '2', 'date_of_birth(1i)' => Time.now.years_ago(15) }) }
  let(:upper_limit)  { described_class.new({'date_of_birth(3i)' => '1', 'date_of_birth(2i)' => '2', 'date_of_birth(1i)' => Time.now.years_ago(71) }) }

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
        expect(impossible_date).not_to be_valid
      end
    end

    context "outside lower and upper age limit" do
      it "is not valid" do
        expect(too_young).not_to be_valid
        expect(upper_limit).not_to be_valid
      end
      
    end
  end

  describe "#next_step" do
    it "returns the next step" do
      expect(date_of_birth.next_step).to eq("uk_or_overseas")
    end
  end
end
