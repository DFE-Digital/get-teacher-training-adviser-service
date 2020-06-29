require "rails_helper"

RSpec.describe Degree::WhatDegreeClass do
  let(:what_degree_class) { build(:degree_what_degree_class) }

  describe "#next_step" do
    it "returns the correct option" do
      expect(what_degree_class.next_step).to eq("degree/stage_interested_teaching")
    end
  end
end
