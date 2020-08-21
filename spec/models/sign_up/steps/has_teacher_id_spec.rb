require "rails_helper"

RSpec.describe SignUp::Steps::HasTeacherId do
  include_context "wizard step"
  it_behaves_like "a wizard step"

  context "attributes" do
    it { is_expected.to respond_to :has_id }
  end

  describe "has_id" do
    it { is_expected.to_not allow_value(nil).for :has_id }
    it { is_expected.to allow_value(true).for :has_id }
    it { is_expected.to allow_value(false).for :has_id }
  end
end
