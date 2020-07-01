require "rails_helper"

RSpec.describe Degree::OverseasTelephone do
  let(:phone) { build(:degree_overseas_telephone) }

  describe "#next_step" do
    it "returns the correct step" do
      expect(phone.next_step).to eq("degree/overseas_completion")
    end
  end
end
