require "rails_helper"

RSpec.describe ApplicationHelper do
  describe "#analytics_body_tag" do
    let(:gtm_id) { "1234" }

    before do
      allow(ENV).to receive(:[]).and_call_original
      allow(ENV).to receive(:[]).with("GOOGLE_TAG_MANAGER_ID").and_return gtm_id
    end

    subject { analytics_body_tag { "<h1>TEST</h1>".html_safe } }

    it { is_expected.to have_css "body h1" }

    context "includes stimulus controllers" do
      it { is_expected.to have_css "body[data-controller~=gtm]" }
    end

    context "assigns service ids" do
      it { is_expected.to have_css "body[data-analytics-gtm-id=1234]" }
    end

    context "with blank service ids" do
      let(:gtm_id) { "" }
      it { is_expected.to have_css "body[data-analytics-gtm-id=\"\"]" }
    end

    context "with no service ids" do
      let(:gtm_id) { nil }
      it { is_expected.not_to have_css "body[data-analytics-gtm-id]" }
    end

    context "with additional stimulus controller" do
      subject { analytics_body_tag(data: { controller: "atest" }) { tag.hr } }
      it { is_expected.to have_css "body[data-controller~=gtm]" }
      it { is_expected.to have_css "body[data-controller~=atest]" }
    end

    context "with other data attributes" do
      subject { analytics_body_tag(data: { timefmt: "24" }) { tag.hr } }
      it { is_expected.to have_css "body[data-controller~=gtm]" }
      it { is_expected.to have_css "body[data-analytics-gtm-id=1234]" }
      it { is_expected.to have_css "body[data-timefmt=24]" }
    end

    context "with other attributes" do
      subject { analytics_body_tag(class: "homepage") { tag.hr } }
      it { is_expected.to have_css "body[data-controller~=gtm]" }
      it { is_expected.to have_css "body.homepage" }
    end
  end
end
