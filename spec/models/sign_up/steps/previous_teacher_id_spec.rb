require "rails_helper"

RSpec.describe SignUp::Steps::PreviousTeacherId do
  include_context "wizard step"
  it_behaves_like "a wizard step"

  context "attributes" do
    it { is_expected.to respond_to :teacher_id }
  end
end
