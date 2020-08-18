require "rails_helper"

RSpec.describe StartTeacherTraining, :vcr do
  subject { build(:start_teacher_training) }

  describe "validation" do
    context "with valid subject option" do
      it "is valid" do
        expect(subject).to be_valid
      end
    end

    context "with invalid subject option" do
      it "is not valid" do
        subject.initial_teacher_training_year_id = "invalid_id"
        expect(subject).to_not be_valid
      end
    end
  end

  describe "#next_step" do
    it "returns the correct option" do
      expect(subject.next_step).to eq("date_of_birth")
    end
  end

  describe "#year_range" do
    let(:starter) { subject.year_range(2) }

    it "returns an array of TypeEntities" do
      expect(starter).to be_an(Array)
      expect(starter.first).to be_an(GetIntoTeachingApiClient::TypeEntity)
    end

    it "returns a range of years starting with 'Not sure'" do
      expect(starter.first.value).to eq("Not sure")
    end
  end
end
