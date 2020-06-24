require 'rails_helper'

RSpec.describe WhatSubjectDegree do
  let(:what_subject_degree) { build(:what_subject_degree) }
  let(:wrong_answer) { build(:what_subject_degree, degree_subject: "dont know") }

  describe "validation" do
    xit "will do something when we have the api" 
  end

  describe "#next_step" do
    it "returns the correct option" do
      expect(what_subject_degree.next_step).to eq("stage_interested_teaching")
    end
  end
end