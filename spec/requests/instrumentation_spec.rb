require "rails_helper"

RSpec.describe "Instrumentation" do
  let(:registry) { Prometheus::Client.registry }

  describe "process_action.action_controller" do
    after { get cookies_path }

    it "increments the :requests_total metric" do
      metric = registry.get(:tta_requests_total)
      expect(metric).to receive(:increment).with(labels: { path: "/cookies", method: "GET", status: 200 }).once
    end

    it "observes the :request_duration_ms metric" do
      metric = registry.get(:tta_request_duration_ms)
      expect(metric).to receive(:observe).with(instance_of(Float), labels: { path: "/cookies", method: "GET", status: 200 }).once
    end

    it "observes the :request_view_runtime_ms metric" do
      metric = registry.get(:tta_request_view_runtime_ms)
      expect(metric).to receive(:observe).with(instance_of(Float), labels: { path: "/cookies", method: "GET", status: 200 }).once
    end
  end

  describe "render_template.action_view" do
    after { get cookie_preference_path }

    it "observes the :render_view_ms metric" do
      metric = registry.get(:tta_render_view_ms)
      expect(metric).to receive(:observe).with(instance_of(Float), labels: {
        identifier: Rails.root.join("app/views/cookie_preferences/show.html.erb").to_s,
      }).once
    end
  end

  describe "render_partial.action_view" do
    after { get root_path }

    it "observes the :render_view_ms metric" do
      metric = registry.get(:tta_render_partial_ms)
      allow(metric).to receive(:observe)
      expect(metric).to receive(:observe).with(instance_of(Float), labels: {
        identifier: Rails.root.join("app/views/layouts/_footer.html.erb").to_s,
      }).once
    end
  end

  describe "cache_read.active_support" do
    after { get privacy_policy_path }

    it "observes the :cache_read_total metric" do
      metric = registry.get(:tta_cache_read_total)
      expect(metric).to receive(:increment).with(labels: {
        key: instance_of(String),
        hit: false,
      }).twice
    end
  end
end
