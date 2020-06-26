require 'rails_helper'

RSpec.describe Degree do
  it "has a LINK constant" do
    expect(Degree::LINK).to eq("degree/")
  end
end