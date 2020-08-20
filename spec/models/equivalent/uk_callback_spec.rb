require "rails_helper"

RSpec.describe Equivalent::UkCallback do
  let(:uk_callback) { build(:equivalent_uk_callback) }

  describe "#next_step" do
    it "returns the next step" do
      expect(uk_callback.next_step).to eq("equivalent/uk_completion")
    end
  end

end
