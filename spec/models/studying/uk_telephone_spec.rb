require 'rails_helper'

RSpec.describe Studying::UkTelephone do
  let(:phone) { build(:studying_uk_telephone) }

  describe "#next_step" do
    it "returns the correct step" do
      expect(phone.next_step).to eq("studying/uk_completion")
    end
  end
end