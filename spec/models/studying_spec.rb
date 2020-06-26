require "rails_helper"

RSpec.describe Studying do
  it "has a LINK constant" do
    expect(Studying::LINK).to eq("studying/")
  end
end
