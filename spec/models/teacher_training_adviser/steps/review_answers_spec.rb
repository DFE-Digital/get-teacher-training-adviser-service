require "rails_helper"

RSpec.describe TeacherTrainingAdviser::Steps::ReviewAnswers do
  include_context "wizard step"
  it_behaves_like "a wizard step"

  it { is_expected.to respond_to :confirmed }

  describe "#confirmed" do
    it "defaults to true" do
      expect(subject.confirmed).to be_truthy
    end

    it { is_expected.to_not allow_value(false).for :confirmed }
    it { is_expected.to allow_value(true).for :confirmed }
  end
end
