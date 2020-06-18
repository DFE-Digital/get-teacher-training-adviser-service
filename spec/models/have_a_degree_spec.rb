require 'rails_helper'

RSpec.describe HaveADegree, :vcr do
  subject { build(:have_a_degree) }

  describe "#degree" do
    it "validates" do
      subject.degree = 'invalid-id'
      expect(subject).to_not be_valid
      subject.degree = HaveADegree::OPTIONS[:yes]
      expect(subject).to be_valid
    end
  end

  describe "#next_step" do
    context "when answer is yes" do
      it "returns the correct option" do
        subject.degree = HaveADegree::OPTIONS[:yes]
        expect(subject.next_step).to eq("degree/what_subject_degree")
      end
    end

    context "when answer is no" do
      it "returns the correct option" do
        subject.degree = HaveADegree::OPTIONS[:no]
        expect(subject.next_step).to eq("no_degree")
      end
    end

    context "when answer is studying" do
      it "returns the correct option" do
        subject.degree = HaveADegree::OPTIONS[:studying]
        expect(subject.next_step).to eq("degree/what_subject_degree")
      end
    end

    context "when answer is equivalent" do
      it "returns the correct option" do
        subject.degree = HaveADegree::OPTIONS[:equivalent]
        expect(subject.next_step).to eq("equivalent/stage_interested_teaching")
      end
    end

  end
end
