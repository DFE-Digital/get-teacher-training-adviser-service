require "rails_helper"

RSpec.describe AnswerHelper, type: :helper do
  describe "#format_answer" do
    let(:time_zone) { "UTC" }

    before { Time.zone = time_zone }

    it "correctly formats a date" do
      answer = Date.new(2011, 1, 24)
      expect(helper.format_answer(answer)).to eq("<span>24 01 2011</span>")
    end

    it "correctly formats a time" do
      answer = Time.utc(2011, 1, 24, 10, 30)
      expect(helper.format_answer(answer)).to eq("<span>10:30</span>")
    end

    it "calls safe_format" do
      answer = "test\ntest"
      expect(helper.format_answer(answer)).to eq("<span>test\n<br />test</span>")
    end

    context "when a time zone has been set" do
      let(:time_zone) { "Hawaii" }

      it "correctly formats a time" do
        answer = Time.utc(2011, 1, 24, 10, 30)
        expect(helper.format_answer(answer)).to eq("<span>00:30</span>")
      end
    end
  end
end
