require 'rails_helper'

RSpec.describe Degree::UkTelephone do
  let(:phone) { build(:degree_uk_telephone) }
  let(:blank_number) { build(:degree_uk_telephone, telephone_number: "") }
  let(:nan) { build(:degree_uk_telephone, telephone_number: "xaseaqewe123") }

  describe "validation" do
    context "with valid input" do
      it "is valid" do
        expect(phone).to be_valid
        expect(blank_number).to be_valid
      end
    end

    context "with non numerical imput" do
      it "is not valid" do
        expect(nan).not_to be_valid
      end
    end
  end

  describe "#next_step" do
    it "returns the correct step" do
      expect(phone.next_step).to eq("degree/uk_completion")
    end
  end
end