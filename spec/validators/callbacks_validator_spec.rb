require "rails_helper"

RSpec.describe CallbacksValidator, :vcr, type: :validator do
  subject { build (:callback) }

  it "is valid when callback_slot returned by API" do
    expect(subject).to be_valid
  end

  it "is invalid when null" do
    subject.callback_slot = nil
    expect(subject).to be_invalid
  end

  it "is invalid when callback not returned by Api" do
    subject.callback_slot = 2
    expect(subject).to be_invalid
  end
end
