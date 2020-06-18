require 'rails_helper'

RSpec.describe Degree::WhatSubjectDegree do
  subject { build(:degree_what_subject_degree) }
  
  describe "#next_step" do
    it "returns the correct option" do
      expect(subject.next_step).to eq("degree/what_degree_class")
    end
  end
end