require "rails_helper"

RSpec.describe Studying::WhatDegreeClass do
  let(:what_degree_class) { build(:studying_what_degree_class) }

  describe "#next_step" do
    it "returns the correct option" do
      expect(what_degree_class.next_step).to eq("studying/stage_interested_teaching")
    end
  end
end
