require 'rails_helper'

RSpec.describe Degree::WhatSubjectDegree do
  let(:what_subject_degree) { build(:degree_what_subject_degree) }

  describe "#next_step" do
    it "returns the correct option" do
      expect(what_subject_degree.next_step).to eq("degree/what_degree_class")
    end
  end
end