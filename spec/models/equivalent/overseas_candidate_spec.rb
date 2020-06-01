require 'rails_helper'

RSpec.describe Equivalent::OverseasCandidate do
  let(:candidate_details) { build(:equivalent_overseas_candidate) }
  let(:no_callback_time) { build(:equivalent_overseas_candidate, callback_time: "") }

  describe "validation" do

    context "without required attributes" do
      it "is invalid" do
        expect(no_callback_time).to_not be_valid
      end
    end

    context "with invalid phone number" do
      ['', '12345uh', '123-123-123'].each do |invalid_phone|
        let(:instance) { build(:equivalent_overseas_candidate, telephone_number: invalid_phone) }
        it "is not valid" do
          expect(instance).to_not be_valid
        end
      end
    end

    context "with valid phone numbers" do
      ['123456', '123456 90'].each do |valid_phone|
        let(:instance) { build(:equivalent_overseas_candidate, telephone_number: valid_phone) }
        it "is valid" do
          expect(instance).to be_valid
        end
      end
    end

  end

  describe '#next_step' do
    it "returns the next step" do
      expect(candidate_details.next_step).to eq('equivalent/overseas_completion')
    end
  end

end