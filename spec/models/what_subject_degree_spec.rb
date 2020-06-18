require 'rails_helper'

RSpec.describe WhatSubjectDegree, :vcr do
  subject { build(:what_subject_degree) }

  describe "#degree_subject" do
    it "validates" do
      subject.degree_subject = 'invalid-id'
      expect(subject).to_not be_valid
      subject.degree_subject = '6b793433-cd1f-e911-a979-000d3a20838a'
      expect(subject).to be_valid
    end
  end

  describe "#next_step" do
    it "returns the correct option" do
      expect(subject.next_step).to eq("stage_interested_teaching")
    end
  end
end