require "rails_helper"

RSpec.describe HaveADegree, :vcr do
  let(:have_a_degree) { build(:have_a_degree) }
  let(:wrong_answer) { build(:have_a_degree, degree: "dont know") }
  let(:no) { build(:have_a_degree, degree: "222750004") }
  let(:studying) { build(:have_a_degree, degree: "222750001") }
  let(:equivalent) { build(:have_a_degree, degree: "222750005") }

  describe "validation" do
    context "with valid answers" do
      HaveADegree::OPTIONS.each do |_k, valid_answer|
        it "is valid" do
          expect(build(:have_a_degree, degree: valid_answer)).to be_valid
        end
      end
    end

    context "with invalid answer" do
      it "is invalid" do
        expect(wrong_answer).not_to be_valid
      end
    end
  end

  describe "#next_step" do
    context "when answer is yes" do
      it "returns the correct option" do
        expect(have_a_degree.next_step).to eq("degree/what_subject_degree")
      end
    end

    context "when answer is no" do
      it "returns the correct option" do
        expect(no.next_step).to eq("no_degree")
      end
    end

    context "when answer is studying" do
      it "returns the correct option" do
        expect(studying.next_step).to eq("studying/stage_of_degree")
      end
    end

    context "when answer is equivalent" do
      it "returns the correct option" do
        expect(equivalent.next_step).to eq("equivalent/stage_interested_teaching")
      end
    end
  end
end
