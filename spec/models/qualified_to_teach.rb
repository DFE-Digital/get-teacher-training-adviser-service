require 'rails_helper'

RSpec.describe QualifiedToTeach do
  let(:qualified_to_teach) { build(:qualified_to_teach) }
  let(:wrong_answer) { build(: qualified_to_teach, qualified_subject: "dont know") }

  describe "validation" do
    context "with invalid subject options" do
      ['skiing', 'fishing', 'golfing', 'surfing' ].each do |invalid_subject|
        let(:instance) { build(:qualified_to_teach, qualified_subject: invalid_subject) }
        it "is not valid" do
          expect(instance).to_not be_valid
        end
      end
    end

    context "with valid subject options" do
      ['English', 'History', 'Science', 'Maths'].each do |valid_subject|
        let(:instance) { build(:qualified_to_teach, qualified_subject: valid_subject) }
        it "is valid" do
          expect(instance).to be_valid
        end
      end
    end
  end

  describe "#next_step" do
    it "returns the correct option" do
      expect(qualified_to_teach.next_step).to eq("date_of_birth")
    end
  end
end