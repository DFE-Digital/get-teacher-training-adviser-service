require "rails_helper"

RSpec.describe WhatDegreeClass do
  subject { build(:what_degree_class) }

  describe "validation" do
    it "validates the uk_degree_grade_id" do
      expect(subject).to be_valid
      subject.uk_degree_grade_id = "invalid_id"
      expect(subject).to_not be_valid
    end
  end

  describe "#next_step" do
    it "returns degree/stage_interested_teaching" do
      expect(subject.next_step).to eq("degree/stage_interested_teaching")
    end
  end
end
