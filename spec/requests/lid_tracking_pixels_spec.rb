require "rails_helper"

RSpec.describe "LID tracking pixels" do
  before { get path }
  subject { response.body }

  context "when visiting /" do
    let(:path) { root_path }

    it { is_expected.to include_analytics("lid", { action: "track", event: "Adviser" }) }
  end

  context "when visiting /teacher_training_adviser/sign_up/completed" do
    let(:path) { completed_teacher_training_adviser_steps_path }

    it { is_expected.to include_analytics("lid", { action: "track", event: "CompleteApp" }) }
  end
end
