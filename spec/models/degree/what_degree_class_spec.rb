require 'rails_helper'

RSpec.describe Degree::WhatDegreeClass do
  let(:what_degree_class) { build(:degree_what_degree_class) }
  let(:wrong_answer) { build(:degree_what_degree_class, degree_class: "dont know") }

  describe "validation" do
    context "with invalid subject options" do
      ['skiing', 'fishing', 'golfing', 'surfing' ].each do |invalid_subject|
        let(:instance) { build(:degree_what_degree_class, degree_class: invalid_subject) }
        it "is not valid" do
          expect(instance).to_not be_valid
        end
      end
    end

    context "with valid subject options" do
      [
        'Not applicable',
        'First class',
        '2:1',
        '2:2',
        'Third class and lower class'
        ].each do |valid_subject|
        let(:instance) { build(:degree_what_degree_class, degree_class: valid_subject) }
        it "is valid" do
          expect(instance).to be_valid
        end
      end
    end
  end

  describe "#next_step" do
    it "returns the correct option" do
      expect(what_degree_class.next_step).to eq("degree/stage_interested_teaching")
    end
  end
end