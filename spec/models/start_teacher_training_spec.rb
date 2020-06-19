require 'rails_helper'

RSpec.describe StartTeacherTraining do
  let(:starter) { build(:start_teacher_training) }
  let(:invalid_instance) { build(:start_teacher_training, year_of_entry: "1999") }

  describe "validation" do
    context "with invalid subject options" do
      it "is not valid" do
        expect(invalid_instance).to_not be_valid
      end
    end

    context "with valid subject options" do
      it "is valid" do
        expect(starter).to be_valid
      end
    end
  end

  describe "#next_step" do
    it "returns the correct option" do
      expect(starter.next_step).to eq("date_of_birth")
    end
  end

  describe "#year_range" do
    subject { starter.year_range(2) }

    it "returns an array of OpenStructs" do
      expect(subject).to be_an(Array)
      expect(subject.first).to be_an(OpenStruct)
    end

    it "returns a range of years starting with current year" do
      expect(subject.first.value).to eq(Date.today.year)
      expect(subject.last.value).to eq(Date.today.next_year(2).year)
    end
  end

end