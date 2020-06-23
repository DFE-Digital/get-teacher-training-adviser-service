require 'rails_helper'

RSpec.describe Equivalent::OverseasCandidate do
  let(:candidate_details) { build(:equivalent_overseas_candidate) }

  describe '#next_step' do
    it "returns the next step" do
      expect(candidate_details.next_step).to eq('equivalent/overseas_completion')
    end
  end

end