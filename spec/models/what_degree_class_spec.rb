require 'rails_helper'

RSpec.describe WhatDegreeClass, :vcr do
  subject { build(:what_degree_class) }

  describe "#degree_class" do
    it "validates" do
      subject.degree_class = 'invalid-id'
      expect(subject).to_not be_valid
      subject.degree_class = '222750006'
      expect(subject).to be_valid
    end
  end
end