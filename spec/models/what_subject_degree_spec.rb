require "rails_helper"

RSpec.describe WhatSubjectDegree, :vcr do
  subject { build(:what_subject_degree) }

  describe "validation" do
    context "with valid subject option" do
      it "is valid" do
        expect(subject).to be_valid
      end
    end

    context "with invalid subject option" do
      it "is not valid" do
        subject.degree_subject = "invalid_id"
        expect(subject).to_not be_valid
      end
    end
  end

  describe "#next_step" do
    it "returns the correct option" do
      expect(subject.next_step).to eq("stage_interested_teaching")
    end
  end
end
