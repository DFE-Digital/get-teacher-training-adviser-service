require "rails_helper"

RSpec.describe PreviousSubject do
  let(:previous) { build(:previous_subject) }
  let(:no_previous) { build(:previous_subject, prev_subject: "") }

  describe "validation" do
    context "with no imput" do
      it "is not valid" do
        expect(no_previous).not_to be_valid
      end
    end
  end

  context "with valid subject options" do
    ["Art and design", "Biology", "Business studies", "Chemistry",
     "Citizenship", "Classics", "Computing", "Dance", "Design and technology",
     "Drama", "English", "French", "Geography", "German", "Health and social care",
     "History", "Languages (other)", "Maths", "Media studies", "French", "Music", "Physical education",
     "Physics", "Physics with maths", "Primary psychology", "Religious education", "Social sciences", "Spanish",
     "Vocational health"].each do |valid_subject|
      let(:instance) { build(:qualified_to_teach, qualified_subject: valid_subject) }
      xit "is valid" do
        expect(build(:qualified_to_teach, qualified_subject: valid_subject)).to be_valid
      end
    end
  end

  describe "#next_step" do
    context "with valid input" do
      it "returns the correct step" do
        expect(previous.next_step).to eq("subject_like_to_teach")
      end
    end
  end
end
