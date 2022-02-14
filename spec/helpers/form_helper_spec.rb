require "rails_helper"

RSpec.describe FormHelper, type: :helper do
  include TextFormatHelper

  describe ".timed_one_time_password_label" do
    subject { timed_one_time_password_label(code_resent) }

    context "when code has not been resent" do
      let(:code_resent) { false }

      it { is_expected.to eq("Enter your code here:") }
    end

    context "when code has been resent" do
      let(:code_resent) { true }

      it { is_expected.to start_with("Enter your code here:") }
      it { is_expected.to end_with("<br><b>We've sent you another email</b>") }
    end
  end
end
