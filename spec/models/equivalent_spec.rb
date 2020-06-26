require 'rails_helper'

RSpec.describe Equivalent do
  it "has a LINK constant" do
    expect(Equivalent::LINK).to eq("equivalent/")
  end
end