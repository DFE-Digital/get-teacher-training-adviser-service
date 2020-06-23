require 'rails_helper'

RSpec.describe Studying::WhatSubjectDegree do
  let(:what_subject_degree) { build(:studying_what_subject_degree) }

  describe "#next_step" do
    it "returns the correct option" do
      expect(what_subject_degree.next_step).to eq("studying/what_degree_class")
    end
  end
end