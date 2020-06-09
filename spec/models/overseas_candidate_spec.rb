require 'rails_helper'

RSpec.describe OverseasCandidate do
  let(:candidate_details) { build(:overseas_candidate) }
  let(:no_callback_time) { build(:overseas_candidate, callback_time: "") }
  let(:yesterday) { build(:overseas_candidate, callback_date: Date.yesterday) }

  describe "validation" do
    context "with required attributes" do
      it "is valid" do
        expect(candidate_details).to be_valid
      end
    end

    context "without required attributes" do
      it "is invalid" do
        expect(no_callback_time).to_not be_valid
      end
    end

    context "with date in the past" do
      it "is invalid" do
        expect(yesterday).to_not be_valid
      end
    end

    context "with invalid phone number" do
      ['', '12345uh', '123-123-123'].each do |invalid_phone|
        let(:instance) { build(:overseas_candidate, telephone_number: invalid_phone) }
        it "is not valid" do
          expect(instance).to_not be_valid
        end
      end
    end

    context "with valid phone numbers" do
      ['123456', '123456 90'].each do |valid_phone|
        let(:instance) { build(:overseas_candidate, telephone_number: valid_phone) }
        it "is valid" do
          expect(instance).to be_valid
        end
      end
    end

  end

  describe '#next_step' do
    it "returns the next step" do
      expect(candidate_details.next_step).to eq('overseas_completion')
    end
  end

end