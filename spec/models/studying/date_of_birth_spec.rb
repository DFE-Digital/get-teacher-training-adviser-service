require 'rails_helper'

RSpec.describe Studying::DateOfBirth do
  let(:date_of_birth) { described_class.new({'date_of_birth(3i)' => '1', 'date_of_birth(2i)' => '12', 'date_of_birth(1i)' => '2001'}) }

  describe "#next_step" do
    it "returns the next step" do
      expect(date_of_birth.next_step).to eq("studying/uk_or_overseas")
    end
  end

end