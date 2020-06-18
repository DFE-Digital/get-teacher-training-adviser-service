require 'rails_helper'

RSpec.describe Degree::WhatDegreeClass do
  subject { build(:degree_what_degree_class) }

  describe "#next_step" do
    it "returns the correct option" do
      expect(subject.next_step).to eq("degree/stage_interested_teaching")
    end
  end
end