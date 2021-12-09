require "rails_helper"

class StubModel
  include ActiveModel::Model
end

RSpec.describe ApplicationHelper do
  include TextFormatHelper

  describe "#analytics_body_tag" do
    subject { analytics_body_tag { "<h1>TEST</h1>".html_safe } }

    let(:gtm_id) { "1234" }
    let(:adwords_id) { "7890" }
    let(:snapchat_id) { "3456" }
    let(:pinterest_id) { "6543" }
    let(:facebook_id) { "4321" }
    let(:twitter_id) { "1289" }
    let(:lid_id) { "7698" }
    let(:bam_id) { "2135" }

    before do
      allow(Rails.application.config.x).to receive(:legacy_tracking_pixels).and_return(true)
      allow(ENV).to receive(:[]).and_call_original
      allow(ENV).to receive(:[]).with("GOOGLE_TAG_MANAGER_ID").and_return gtm_id
      allow(ENV).to receive(:[]).with("GOOGLE_AD_WORDS_ID").and_return adwords_id
      allow(ENV).to receive(:[]).with("SNAPCHAT_ID").and_return snapchat_id
      allow(ENV).to receive(:[]).with("PINTEREST_ID").and_return pinterest_id
      allow(ENV).to receive(:[]).with("FACEBOOK_ID").and_return facebook_id
      allow(ENV).to receive(:[]).with("TWITTER_ID").and_return twitter_id
      allow(ENV).to receive(:[]).with("LID_ID").and_return lid_id
      allow(ENV).to receive(:[]).with("BAM_ID").and_return bam_id
    end

    it { is_expected.to have_css "body h1" }

    context "when legacy tracking is disabled" do
      subject { analytics_body_tag(data: { timefmt: "24" }, class: "homepage") { tag.hr } }

      before { allow(Rails.application.config.x).to receive(:legacy_tracking_pixels).and_return(false) }

      it { is_expected.not_to have_css "body[data-controller=gtm]" }
      it { is_expected.to have_css "body[data-controller=gtm-consent]" }
      it { is_expected.to have_css "body[data-timefmt=24]" }
      it { is_expected.to have_css "body.homepage" }
      it { is_expected.to have_css "body hr" }
    end

    describe "stimulus controllers" do
      it { is_expected.to have_css "body[data-controller~=gtm]" }
      it { is_expected.to have_css "body[data-controller~=snapchat]" }
      it { is_expected.to have_css "body[data-controller~=pinterest]" }
      it { is_expected.to have_css "body[data-controller~=facebook]" }
      it { is_expected.to have_css "body[data-controller~=twitter]" }
    end

    describe "service ids" do
      it { is_expected.to have_css "body[data-analytics-gtm-id=1234]" }
      it { is_expected.to have_css "body[data-analytics-adwords-id=7890]" }
      it { is_expected.to have_css "body[data-analytics-snapchat-id=3456]" }
      it { is_expected.to have_css "body[data-analytics-pinterest-id=6543]" }
      it { is_expected.to have_css "body[data-analytics-facebook-id=4321]" }
      it { is_expected.to have_css "body[data-analytics-twitter-id=1289]" }
      it { is_expected.to have_css "body[data-analytics-lid-id=7698]" }
      it { is_expected.to have_css "body[data-analytics-bam-id=2135]" }
    end

    context "with blank service ids" do
      let(:gtm_id) { "" }
      let(:adwords_id) { "" }
      let(:twitter_id) { "" }
      let(:lid_id) { "" }
      let(:bam_id) { "" }

      it { is_expected.to have_css "body[data-analytics-gtm-id=\"\"]" }
      it { is_expected.to have_css "body[data-analytics-adwords-id=\"\"]" }
      it { is_expected.to have_css "body[data-analytics-twitter-id=\"\"]" }
      it { is_expected.to have_css "body[data-analytics-lid-id=\"\"]" }
      it { is_expected.to have_css "body[data-analytics-bam-id=\"\"]" }
    end

    context "with no service ids" do
      let(:gtm_id) { nil }
      let(:adwords_id) { nil }
      let(:twitter_id) { nil }
      let(:lid_id) { nil }
      let(:bam_id) { nil }

      it { is_expected.not_to have_css "body[data-analytics-gtm-id]" }
      it { is_expected.not_to have_css "body[data-analytics-adwords-id]" }
      it { is_expected.not_to have_css "body[data-analytics-twitter-id]" }
      it { is_expected.not_to have_css "body[data-analytics-lid-id]" }
      it { is_expected.not_to have_css "body[data-analytics-bam-id]" }
    end

    describe "default events" do
      it { is_expected.to have_css "body[data-snapchat-action-value=track]" }
      it { is_expected.to have_css "body[data-snapchat-event-value=PAGE_VIEW]" }
      it { is_expected.to have_css "body[data-facebook-action-value=track]" }
      it { is_expected.to have_css "body[data-facebook-event-value=PageView]" }
      it { is_expected.to have_css "body[data-twitter-action-value=track]" }
      it { is_expected.to have_css "body[data-twitter-event-value=PageView]" }
    end

    context "with additional stimulus controller" do
      subject { analytics_body_tag(data: { controller: "atest" }) { tag.hr } }

      it { is_expected.to have_css "body[data-controller~=gtm]" }
      it { is_expected.to have_css "body[data-controller~=twitter]" }
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

  describe "#govuk_form_for" do
    it "renders a form with GOV.UK form builder" do
      expect(govuk_form_for(StubModel.new, url: "http://test.com") {}).to eq(
        "<form class=\"new_stub_model\" id=\"new_stub_model\" novalidate=\"novalidate\" "\
        "action=\"http://test.com\" accept-charset=\"UTF-8\" method=\"post\"></form>",
      )
    end
  end

  describe "#back_link" do
    it "renders a back link with GOV.UK class names" do
      expect(back_link).to eq("<a class=\"govuk-back-link\" href=\"javascript:history.back()\">Back</a>")
    end
  end

  describe "#link_to_change_answer" do
    it "returns a link to the sign up step" do
      expect(link_to_change_answer(TeacherTrainingAdviser::Steps::Identity)).to eq(
        "<a href=\"/teacher_training_adviser/sign_up/identity\">Change <span class=\"visually-hidden\"> identity</span></a>",
      )
    end
  end

  describe "#new_gtm_enabled?" do
    it "returns true when GTM_ID is present and legacy_tracking_pixels is false" do
      allow(ENV).to receive(:[]).with("GTM_ID").and_return("ABC-123")
      allow(Rails.application.config.x).to receive(:legacy_tracking_pixels).and_return(false)

      expect(helper).to be_new_gtm_enabled
    end

    it "returns false when GTM_ID is blank or legacy_tracking_pixels is true" do
      allow(ENV).to receive(:[]).with("GTM_ID").and_return("ABC-123")
      allow(Rails.application.config.x).to receive(:legacy_tracking_pixels).and_return(true)

      expect(helper).not_to be_new_gtm_enabled

      allow(ENV).to receive(:[]).with("GTM_ID").and_return(nil)
      allow(Rails.application.config.x).to receive(:legacy_tracking_pixels).and_return(false)

      expect(helper).not_to be_new_gtm_enabled
    end
  end

  describe "#link_to_git" do
    subject { link_to_git_site }

    let(:url) { "http://test.url/" }

    before do
      allow(ENV).to receive(:[]).and_call_original
      allow(ENV).to receive(:[]).with("GIT_URL").and_return url
    end

    context "without text" do
      it { is_expected.to have_css 'a[href="http://test.url/"]' }
      it { is_expected.to have_css "a", text: "Get into Teaching" }
    end

    context "with text" do
      subject { link_to_git_site "Teaching site" }

      it { is_expected.to have_css 'a[href="http://test.url/"]' }
      it { is_expected.to have_css "a", text: "Teaching site" }
    end

    context "with path" do
      subject { link_to_git_site "Show content", "content/page" }

      it { is_expected.to have_css 'a[href="http://test.url/content/page"]' }
      it { is_expected.to have_css "a", text: "Show content" }
    end

    context "with attributes" do
      subject { link_to_git_site "Teaching site", "", class: "govuk-link" }

      it { is_expected.to have_css 'a.govuk-link[href="http://test.url/"]' }
      it { is_expected.to have_css "a.govuk-link", text: "Teaching site" }
    end

    context "when URL is nil" do
      before { allow(ENV).to receive(:[]).with("GIT_URL").and_return nil }

      it { is_expected.to have_css 'a[href="/url-not-set/"]' }
      it { is_expected.to have_css "a", text: "Get into Teaching" }
    end

    context "when URL empty" do
      before { allow(ENV).to receive(:[]).with("GIT_URL").and_return "" }

      it { is_expected.to have_css 'a[href="/url-not-set/"]' }
      it { is_expected.to have_css "a", text: "Get into Teaching" }
    end
  end

  describe "#link_to_git_mailing_list" do
    subject { link_to_git_mailing_list("join the mailing list", class: "govuk-link") }

    let(:url) { "http://test.url/" }

    before { allow(ENV).to receive(:[]).with("GIT_URL") { url } }

    it { is_expected.to have_css "a[href=\"http://test.url/mailinglist/signup\"]" }
    it { is_expected.to have_css "a.govuk-link", text: "join the mailing list" }

    context "when the GIT_URL is nil" do
      before { allow(ENV).to receive(:[]).with("GIT_URL").and_return(nil) }

      it { is_expected.to have_css "a[href=\"/url-not-set/mailinglist/signup\"]" }
      it { is_expected.to have_css "a", text: "join the mailing list" }
    end

    context "when the GIT_URL is an empty string" do
      before { allow(ENV).to receive(:[]).with("GIT_URL").and_return(" ") }

      it { is_expected.to have_css "a[href=\"/url-not-set/mailinglist/signup\"]" }
      it { is_expected.to have_css "a", text: "join the mailing list" }
    end
  end

  describe "#link_to_git_events" do
    subject { link_to_git_events("find an event", class: "govuk-link") }

    let(:url) { "http://test.url/" }

    before { allow(ENV).to receive(:[]).with("GIT_URL") { url } }

    it { is_expected.to have_css "a[href=\"http://test.url/events\"]" }
    it { is_expected.to have_css "a.govuk-link", text: "find an event" }

    context "when the GIT_URL is nil" do
      before { allow(ENV).to receive(:[]).with("GIT_URL").and_return(nil) }

      it { is_expected.to have_css "a[href=\"/url-not-set/events\"]" }
      it { is_expected.to have_css "a", text: "find an event" }
    end

    context "when the GIT_URL is an empty string" do
      before { allow(ENV).to receive(:[]).with("GIT_URL").and_return(" ") }

      it { is_expected.to have_css "a[href=\"/url-not-set/events\"]" }
      it { is_expected.to have_css "a", text: "find an event" }
    end

    context "when provided with a custom events_path" do
      subject { link_to_git_events(link_text, events_path: events_path, class: link_class) }

      let(:link_text) { "find a special online event" }
      let(:link_class) { "special-online-event-link" }
      let(:events_path) { "online/special" }

      it { is_expected.to have_link(link_text, href: git_url + "events/#{events_path}", class: link_class) }
    end
  end

  describe "#internal_referer" do
    it "returns nil if the referrer is not set" do
      helper.request = double("request", referer: nil)
      expect(helper.internal_referer).to be_nil
    end

    it "returns nil if the referrer is empty" do
      helper.request = double("request", referer: " ")
      expect(helper.internal_referer).to be_nil
    end

    it "returns nil if the referrer is external" do
      helper.request = double("request", referer: " ")
      expect(helper.internal_referer).to be_nil
    end

    it "returns the referrer if internal" do
      helper.request = double("request", referer: root_url)
      expect(helper.internal_referer).to eql(root_url)
    end
  end

  describe "#human_boolean" do
    it { expect(human_boolean(true)).to eq("Yes") }
    it { expect(human_boolean(false)).to eq("No") }
  end
end
