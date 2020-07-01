require "rails_helper"

RSpec.describe Studying::OverseasTelephone do
  let(:phone) { build(:studying_overseas_telephone) }

  describe "#next_step" do
    it "returns the correct step" do
      expect(phone.next_step).to eq("studying/overseas_completion")
    end
  end
end
