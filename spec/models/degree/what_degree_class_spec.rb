require "rails_helper"

RSpec.describe Degree::WhatDegreeClass, :vcr do
  subject { build(:degree_what_degree_class) }

  describe "validation" do
    context "with valid subject option" do
      it "is valid" do
        expect(subject).to be_valid
      end
    end

    context "with invalid subject option" do
      it "is not valid" do
        subject.degree_class = "invalid_id"
        expect(subject).to_not be_valid
      end
    end
  end

  describe "#next_step" do
    it "returns the correct option" do
      expect(subject.next_step).to eq("degree/stage_interested_teaching")
    end
  end
end
