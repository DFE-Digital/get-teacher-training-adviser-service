require "rails_helper"

RSpec.describe SignUp::Steps::Callback do
  include_context "wizard step"
  it_behaves_like "a wizard step"

  context "attributes" do
    it { is_expected.to respond_to :phone_call_scheduled_at }
    it { is_expected.to respond_to :telephone }
  end

  context "phone_call_scheduled_at" do
    it { is_expected.to_not allow_value("").for :phone_call_scheduled_at }
    it { is_expected.to_not allow_value(nil).for :phone_call_scheduled_at }
    it { is_expected.to_not allow_value("invalid_date").for :phone_call_scheduled_at }
    it { is_expected.to allow_value(Time.zone.now).for :phone_call_scheduled_at }
  end

  context "telephone" do
    it { is_expected.to_not allow_value("").for :telephone }
    it { is_expected.to_not allow_value("12345uh").for :telephone }
    it { is_expected.to_not allow_value("123-123-123").for :telephone }
    it { is_expected.to allow_value("123456").for :telephone }
    it { is_expected.to allow_value("123456 90").for :telephone }
  end

  describe "#self.options" do
    it "is a pending example"
  end
end
