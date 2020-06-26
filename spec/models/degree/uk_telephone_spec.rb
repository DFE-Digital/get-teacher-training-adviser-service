require "rails_helper"

RSpec.describe Degree::UkTelephone do
  let(:phone) { build(:degree_uk_telephone) }

  describe "#next_step" do
    it "returns the correct step" do
      expect(phone.next_step).to eq("degree/uk_completion")
    end
  end
end
