require 'rails_helper'

RSpec.describe Degree::StartTeacherTraining do
  let(:starter) { build(:degree_start_teacher_training) }

  describe "validation" do
    context "with invalid subject options" do
      ['skiing', '2030', '1995', 'surfing' ].each do |invalid_year|
        let(:instance) { build(:degree_start_teacher_training, year_of_entry: invalid_year) }
        it "is not valid" do
          expect(instance).to_not be_valid
        end
      end
    end

    context "with valid subject options" do
      ['2020', '2021', '2022'].each do |valid_year|
        let(:instance) { build(:degree_start_teacher_training, year_of_entry: valid_year) }
        it "is valid" do
          expect(instance).to be_valid
        end
      end
    end
  end

  describe "#next_step" do
    it "returns the correct option" do
      expect(starter.next_step).to eq("degree/date_of_birth")
    end
  end
end