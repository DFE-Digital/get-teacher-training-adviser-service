require 'rails_helper'

RSpec.describe PreviousId do
  let(:previous) { build(:previous_id) }
  let(:no_previous) { build(:previous_id, prev_id: "") }

  describe "validation" do
    context "with some input" do
      it "is valid" do
        expect(previous).to be_valid
      end
    end

    context "with no imput" do
      it "is valid" do
        expect(no_previous).to be_valid
      end
    end
  end

  describe "#next_step" do
    context "with valid input" do
      it "returns the correct step" do
        expect(previous.next_step).to eq("previous_subject")
      end
    end
  end
end