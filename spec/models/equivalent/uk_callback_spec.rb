require 'rails_helper'

RSpec.describe Equivalent::UkCallback do
  let(:candidate_details) { build(:equivalent_uk_callback) }
  let(:no_callback_time) { build(:equivalent_overseas_candidate, callback_time: "") }

  describe '#next_step' do
    it "returns the next step" do
      expect(candidate_details.next_step).to eq('equivalent/uk_completion')
    end
  end

end