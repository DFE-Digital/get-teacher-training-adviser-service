require "rails_helper"

RSpec.describe Equivalent::UkCallback, :vcr do
  let(:uk_callback) { build(:equivalent_uk_callback) }

  describe "#next_step" do
    it "returns the next step" do
      expect(uk_callback.next_step).to eq("equivalent/uk_completion")
    end
  end

  describe "#self.options" do
    include_context "callback_options_hash"
    include_examples "callback_options"
  end
end
