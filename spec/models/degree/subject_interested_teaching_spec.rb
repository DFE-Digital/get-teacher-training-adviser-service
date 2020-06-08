require 'rails_helper'

RSpec.describe Degree::SubjectInterestedTeaching do
  let(:what_subject) { build(:degree_subject_interested_teaching) }

  describe "validation" do
    context "with invalid subject options" do
      ['skiing', 'fishing', 'golfing', 'surfing' ].each do |invalid_subject|
        let(:instance) { build(:degree_subject_interested_teaching, teaching_subject: invalid_subject) }
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
        let(:instance) { build(:degree_subject_interested_teaching, teaching_subject: valid_subject) }
        it "is valid" do
          expect(instance).to be_valid
        end
      end
    end
  end

  describe "#next_step" do
    it "returns the correct option" do
      expect(what_subject.next_step).to eq("degree/start_teacher_training")
    end
  end
end