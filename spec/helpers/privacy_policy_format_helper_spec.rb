require "rails_helper"

RSpec.describe PrivacyPolicyFormatHelper, type: :helper do
  describe "#safe_format" do
    subject { safe_format content }

    context "with new lines" do
      let(:content) { "hello\r\n\r\nworld" }
      it "wraps content as paragraph" do
        expect(subject).to eq("<p>hello</p>\n\n<p>world</p>")
      end
    end

    context "with html content" do
      let(:content) { "<strong>hello</strong> <em>world</em>" }
      it "removes tags and wraps content as paragraph" do
        expect(subject).to eq("<p>hello world</p>")
      end
    end
  end
end
