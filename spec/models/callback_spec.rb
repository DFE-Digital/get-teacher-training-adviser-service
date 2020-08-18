require "rails_helper"

RSpec.describe Callback, :vcr do
  subject { build(:callback) }
  let(:no_callback_slot) { build(:callback, phone_call_scheduled_at: "") }

  describe "validation" do
    context "with required attributes" do
      it "is valid" do
        expect(subject).to be_valid
      end
    end

    context "without required attributes" do
      it "is invalid" do
        expect(no_callback_slot).to_not be_valid
      end
    end

    context "with invalid phone_call_scheduled_at" do
      it "is invalid" do
        subject.phone_call_scheduled_at = "invalid_date"
        expect(subject).to_not be_valid
      end
    end

    context "with invalid phone number" do
      ["", "12345uh", "123-123-123"].each do |invalid_phone|
        it "is not valid" do
          expect(build(:equivalent_uk_callback, telephone: invalid_phone)).to_not be_valid
        end
      end
    end

    context "with valid phone numbers" do
      ["123456", "123456 90"].each do |valid_phone|
        it "is valid" do
          expect(build(:equivalent_uk_callback, telephone: valid_phone)).to be_valid
        end
      end
    end
  end

  describe "#self.options" do
    include_context "callback_options_hash"
    include_examples "callback_options"
  end

  describe "#self.remove_current_day" do
    include_context "callback_remove_current_day"
    include_examples "callback_options_remove_current_day"
  end
end
