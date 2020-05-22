require 'rails_helper'

RSpec.describe StartTeacherTraining do
  let(:starter) { build(:start_teacher_training) }

  describe "validation" do
    context "with invalid subject options" do
      ['skiing', '2030', '1995', 'surfing' ].each do |invalid_year|
        let(:instance) { build(:start_teacher_training, year_of_entry: invalid_year) }
        it "is not valid" do
          expect(instance).to_not be_valid
        end
      end
    end

    context "with valid subject options" do
      ['2020', '2021', '2022'].each do |valid_year|
        let(:instance) { build(:start_teacher_training, year_of_entry: valid_year) }
        it "is valid" do
          expect(instance).to be_valid
        end
      end
    end
  end

  describe "#next_step" do
    it "returns the correct option" do
      expect(starter.next_step).to eq("date_of_birth")
    end
  end
end