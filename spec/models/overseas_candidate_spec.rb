require "rails_helper"

RSpec.describe OverseasCandidate, :vcr do
  subject { build(:overseas_candidate) }
  let(:no_callback_slot) { build(:overseas_candidate, phone_call_scheduled_at: "") }
  let(:no_time_zone) { build(:overseas_candidate, time_zone: "") }

  describe "validation" do
    context "with required attributes" do
      it "is valid" do
        expect(subject).to be_valid
      end
    end

    context "with invalid callback id" do
      it "is invalid" do
        subject.phone_call_scheduled_at = "invalid_id"
        expect(subject).to_not be_valid
      end
    end

    context "without required attributes" do
      it "is invalid" do
        expect(no_callback_slot).to_not be_valid
        expect(no_time_zone).to_not be_valid
      end
    end

    context "with invalid phone number" do
      ["", "12345uh", "123-123-123"].each do |invalid_phone|
        it "is not valid" do
          expect(build(:overseas_candidate, telephone: invalid_phone)).to_not be_valid
        end
      end
    end

    context "with valid phone numbers" do
      ["123456", "123456 90"].each do |valid_phone|
        it "is valid" do
          expect(build(:overseas_candidate, telephone: valid_phone)).to be_valid
        end
      end
    end
  end

  describe "#next_step" do
    it "returns the next step" do
      expect(subject.next_step).to eq("overseas_completion")
    end
  end
end
