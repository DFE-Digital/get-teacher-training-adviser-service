require "rails_helper"

RSpec.describe Prometheus::Metrics do
  let(:registry) { Prometheus::Client.registry }

  describe "tta_client_cookie_consent_total" do
    subject { registry.get(:tta_client_cookie_consent_total) }

    it { is_expected.not_to be_nil }
    it { is_expected.to have_attributes(docstring: "A counter of cookie consent") }
    it { expect { subject.get(labels: %i[non_functional marketing]) }.not_to raise_error }
    it { is_expected.to have_attributes(preset_labels: expected_preset_labels) }
  end

  describe "tta_request_total" do
    subject { registry.get(:tta_requests_total) }

    it { is_expected.not_to be_nil }
    it { is_expected.to have_attributes(docstring: "A counter of requests") }
    it { expect { subject.get(labels: %i[path method status]) }.not_to raise_error }
  end

  describe "tta_request_duration_ms" do
    subject { registry.get(:tta_request_duration_ms) }

    it { is_expected.not_to be_nil }
    it { is_expected.to have_attributes(docstring: "A histogram of request durations") }
    it { is_expected.to have_attributes(preset_labels: expected_preset_labels) }
    it { expect { subject.get(labels: %i[path method status]) }.not_to raise_error }
  end

  describe "tta_request_view_runtime_ms" do
    subject { registry.get(:tta_request_view_runtime_ms) }

    it { is_expected.not_to be_nil }
    it { is_expected.to have_attributes(docstring: "A histogram of request view runtimes") }
    it { is_expected.to have_attributes(preset_labels: expected_preset_labels) }
    it { expect { subject.get(labels: %i[path method status]) }.not_to raise_error }
  end

  describe "tta_render_view_ms" do
    subject { registry.get(:tta_render_view_ms) }

    it { is_expected.not_to be_nil }
    it { is_expected.to have_attributes(docstring: "A histogram of view rendering times") }
    it { is_expected.to have_attributes(preset_labels: expected_preset_labels) }
    it { expect { subject.get(labels: %i[identifier]) }.not_to raise_error }
  end

  describe "tta_render_partial_ms" do
    subject { registry.get(:tta_render_partial_ms) }

    it { is_expected.not_to be_nil }
    it { is_expected.to have_attributes(docstring: "A histogram of partial rendering times") }
    it { is_expected.to have_attributes(preset_labels: expected_preset_labels) }
    it { expect { subject.get(labels: %i[identifier]) }.not_to raise_error }
  end

  describe "tta_cache_read_total" do
    subject { registry.get(:tta_cache_read_total) }

    it { is_expected.not_to be_nil }
    it { is_expected.to have_attributes(docstring: "A counter of cache reads") }
    it { is_expected.to have_attributes(preset_labels: expected_preset_labels) }
    it { expect { subject.get(labels: %i[key hit]) }.not_to raise_error }
  end

  describe "tta_csp_violations_total" do
    subject { registry.get(:tta_csp_violations_total) }

    it { is_expected.not_to be_nil }
    it { is_expected.to have_attributes(docstring: "A counter of CSP violations") }
    it { is_expected.to have_attributes(preset_labels: expected_preset_labels) }
    it { expect { subject.get(labels: %i[blocked_uri document_uri violated_directive]) }.not_to raise_error }
  end

  describe "tta_feedback_visit_total" do
    subject { registry.get(:tta_feedback_visit_total) }

    it { is_expected.not_to be_nil }
    it { is_expected.to have_attributes(docstring: "A counter of feedback visit responses") }
    it { is_expected.to have_attributes(preset_labels: expected_preset_labels) }
    it { expect { subject.get(labels: %i[successful]) }.not_to raise_error }
  end

  describe "tta_feedback_rating_total" do
    subject { registry.get(:tta_feedback_rating_total) }

    it { is_expected.not_to be_nil }
    it { is_expected.to have_attributes(docstring: "A counter of feedback rating responses") }
    it { is_expected.to have_attributes(preset_labels: expected_preset_labels) }
    it { expect { subject.get(labels: %i[rating]) }.not_to raise_error }
  end

  def expected_preset_labels
    {
      app: "app-name",
      organisation: "org-name",
      space: "space-name",
      app_instance: "app-instance",
    }
  end
end
