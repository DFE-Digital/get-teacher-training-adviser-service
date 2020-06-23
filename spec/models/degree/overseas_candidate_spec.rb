require 'rails_helper'

RSpec.describe Degree::OverseasCandidate do
  let(:candidate_details) { build(:degree_overseas_candidate) }
  let(:no_callback_time) { build(:degree_overseas_candidate, callback_time: "") }

  describe '#next_step' do
    it "returns the next step" do
      expect(candidate_details.next_step).to eq('degree/overseas_completion')
    end
  end

end