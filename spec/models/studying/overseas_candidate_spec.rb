require 'rails_helper'

RSpec.describe Studying::OverseasCandidate do
  let(:candidate_details) { build(:studying_overseas_candidate) }

  describe '#next_step' do
    it "returns the next step" do
      expect(candidate_details.next_step).to eq('studying/overseas_completion')
    end
  end

end