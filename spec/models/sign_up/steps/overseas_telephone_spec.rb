require "rails_helper"

RSpec.describe SignUp::Steps::OverseasTelephone do
  include_context "wizard step"
  it_behaves_like "a wizard step"

  context "attributes" do
    it { is_expected.to respond_to :telephone }
  end

  describe "telephone" do
    it { is_expected.to_not allow_value("abc12345").for :telephone }
    it { is_expected.to_not allow_value("12").for :telephone }
    it { is_expected.to_not allow_value("93837537372758327832726823").for :telephone }
    it { is_expected.to allow_value(nil).for :telephone }
    it { is_expected.to allow_value("").for :telephone }
    it { is_expected.to allow_value("123456789").for :telephone }
  end
end
