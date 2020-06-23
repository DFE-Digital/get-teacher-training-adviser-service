require 'rails_helper'

RSpec.describe Studying::OverseasCountry do
  let(:country) { build(:studying_overseas_country) }

  describe "#next_step" do
    it "returns the correct step" do
      expect(country.next_step).to eq("studying/overseas_candidate")
    end
  end
  
end