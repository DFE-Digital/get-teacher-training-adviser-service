require "rails_helper"

class StubModel
  include ActiveModel::Model
end

RSpec.describe ApplicationHelper do
  include TextFormatHelper

  describe "#analytics_body_tag" do
    subject { analytics_body_tag(data: { timefmt: "24" }, class: "homepage") { tag.hr } }

    it { is_expected.not_to have_css "body[data-controller=gtm]" }
    it { is_expected.to have_css "body[data-controller=gtm-consent]" }
    it { is_expected.to have_css "body[data-timefmt=24]" }
    it { is_expected.to have_css "body.homepage" }
    it { is_expected.to have_css "body hr" }
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
      expect(link_to_change_answer(TeacherTrainingAdviser::Steps::Identity, "email")).to eq(
        "<a href=\"/teacher_training_adviser/sign_up/identity\">Change <span class=\"visually-hidden\"> your email</span></a>",
      )
    end
  end

  describe "#gtm_enabled?" do
    it "returns true when GTM_ID is present" do
      allow(ENV).to receive(:[]).with("GTM_ID").and_return("ABC-123")
      expect(helper).to be_gtm_enabled
    end

    it "returns false when GTM_ID is blank" do
      allow(ENV).to receive(:[]).with("GTM_ID").and_return("")
      expect(helper).not_to be_gtm_enabled

      allow(ENV).to receive(:[]).with("GTM_ID").and_return(nil)
      expect(helper).not_to be_gtm_enabled
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
      helper.request = instance_double(ActionDispatch::Request, referer: nil)
      expect(helper.internal_referer).to be_nil
    end

    it "returns nil if the referrer is empty" do
      helper.request = instance_double(ActionDispatch::Request, referer: " ")
      expect(helper.internal_referer).to be_nil
    end

    it "returns nil if the referrer is external" do
      helper.request = instance_double(ActionDispatch::Request, referer: "http://external.com")
      expect(helper.internal_referer).to be_nil
    end

    it "returns the referrer if internal" do
      helper.request = instance_double(ActionDispatch::Request, referer: root_url)
      expect(helper.internal_referer).to eql(root_url)
    end
  end

  describe "#human_boolean" do
    it { expect(human_boolean(true)).to eq("Yes") }
    it { expect(human_boolean(false)).to eq("No") }
  end
end
