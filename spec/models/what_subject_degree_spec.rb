require 'rails_helper'

RSpec.describe WhatSubjectDegree do
  let(:what_subject_degree) { build(:what_subject_degree) }
  let(:wrong_answer) { build(:what_subject_degree, degree_subject: "dont know") }

  describe "validation" do
    context "with invalid subject options" do
      ['skiing', 'fishing', 'golfing', 'surfing' ].each do |invalid_subject|
        let(:instance) { build(:what_subject_degree, degree_subject: invalid_subject) }
        it "is not valid" do
          expect(instance).to_not be_valid
        end
      end
    end

    context "with valid subject options" do
      [
        'Art and design', 
        'Biology',
        'Business studies', 
        'Chemistry',
        'Citizenship', 
        'Classics',
        'Computing', 
        'Dance',
        'Design and technology',
        'Drama',
        'Economic', 
        'English',
        'French',
        'Geography', 
        'German',
        'Health and social care', 
        'History',
        'Languages (other)', 
        'Maths',
        'Media studies', 
        'French',
        'Music',
        'Physical education', 
        'Physics',
        'Physics with maths',
        'Primary psychology',
        'Religious education',
        'Social sciences',
        'Spanish',
        'Vocational health'].each do |valid_subject|
        it "is valid" do
          expect(build(:what_subject_degree, degree_subject: valid_subject)).to be_valid
        end
      end
    end
  end

  describe "#next_step" do
    it "returns the correct option" do
      expect(what_subject_degree.next_step).to eq("stage_interested_teaching")
    end
  end
end