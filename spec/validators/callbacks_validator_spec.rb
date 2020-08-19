require "rails_helper"

RSpec.describe CallbacksValidator, type: :validator do
  subject { build :callback }

  it "is valid when phone_call_scheduled_at returned by API" do
    expect(subject).to be_valid
  end

  it "is invalid when null" do
    subject.phone_call_scheduled_at = nil
    expect(subject).to be_invalid
  end

  it "is invalid when callback not returned by Api" do
    subject.phone_call_scheduled_at = 2
    expect(subject).to be_invalid
  end
end
