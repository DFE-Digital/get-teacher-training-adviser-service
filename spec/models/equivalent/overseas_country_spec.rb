require 'rails_helper'

RSpec.describe Degree::OverseasCountry do
  let(:country) { build(:equivalent_overseas_country) }

  describe "#next_step" do
    it "returns the correct step" do
      expect(country.next_step).to eq("equivalent/overseas_candidate")
    end
  end
  
end