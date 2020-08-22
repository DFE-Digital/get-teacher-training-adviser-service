require "rails_helper"

RSpec.describe SignUp::Steps::WhatSubjectDegree do
  include_context "wizard step"
  it_behaves_like "a wizard step"

  context "attributes" do
    it { is_expected.to respond_to :degree_subject }
  end

  describe "#degree_subject" do
    it { is_expected.to_not allow_values("", nil).for :degree_subject }
    it { is_expected.to allow_value("Maths").for :degree_subject }
  end

  describe "#skipped?" do
    it "returns false if degree_options is studying/degree" do
      wizardstore["degree_options"] = HaveADegree::DEGREE_OPTIONS[:studying]
      expect(subject).to_not be_skipped
      wizardstore["degree_options"] = HaveADegree::DEGREE_OPTIONS[:degree]
      expect(subject).to_not be_skipped
    end

    it "returns true if degree_options is not studying/degree" do
      wizardstore["degree_options"] = HaveADegree::DEGREE_OPTIONS[:equivalent]
      expect(subject).to be_skipped
    end
  end
end
