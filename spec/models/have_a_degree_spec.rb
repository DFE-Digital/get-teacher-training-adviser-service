require "rails_helper"

RSpec.describe HaveADegree do
  let(:have_a_degree) { build(:have_a_degree) }
  let(:wrong_answer) { build(:have_a_degree, degree_options: "dont know") }
  let(:no) { build(:have_a_degree, degree_options: HaveADegree::DEGREE_OPTIONS[:no]) }
  let(:studying) { build(:have_a_degree, degree_options: HaveADegree::DEGREE_OPTIONS[:studying]) }
  let(:equivalent) { build(:have_a_degree, degree_options: HaveADegree::DEGREE_OPTIONS[:equivalent]) }

  describe "validation" do
    context "with valid answers" do
      HaveADegree::DEGREE_OPTIONS.each do |_k, valid_answer|
        it "is valid" do
          expect(build(:have_a_degree, degree_options: valid_answer)).to be_valid
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
    context "when answer is degree" do
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

  describe "#set_degree_status" do
    context "with degree_option degree" do
      it "sets the correct degree_status_id before validation" do
        have_a_degree.valid?
        expect(have_a_degree.degree_status_id).to eq(HaveADegree::DEGREE_STATUS_OPTIONS[:yes])
      end
    end

    context "with degree_option no" do
      it "sets the correct degree_status_id before validation" do
        no.valid?
        expect(no.degree_status_id).to eq(HaveADegree::DEGREE_STATUS_OPTIONS[:no])
      end
    end

    context "with degree_option studying" do
      it "sets the correct degree_status_id before validation" do
        studying.valid?
        expect(studying.degree_status_id).to eq(HaveADegree::DEGREE_STATUS_OPTIONS[:studying])
      end
    end

    context "with degree_option equivalent" do
      it "sets the correct degree_status_id before validation" do
        equivalent.valid?
        expect(equivalent.degree_status_id).to eq(HaveADegree::DEGREE_STATUS_OPTIONS[:yes])
      end
    end
  end

  describe "#set degree type" do
    context "with degree_option degree" do
      it "sets the correct degree_type_id before validation" do
        have_a_degree.valid?
        expect(have_a_degree.degree_type_id).to eq(HaveADegree::DEGREE_TYPE[:degree])
      end
    end

    context "with degree_option no" do
      it "sets the correct degree_type_id before validation" do
        no.valid?
        expect(no.degree_type_id).to eq(HaveADegree::DEGREE_TYPE[:degree])
      end
    end

    context "with degree_option studying" do
      it "sets the correct degree_type_id before validation" do
        studying.valid?
        expect(studying.degree_type_id).to eq(HaveADegree::DEGREE_TYPE[:degree])
      end
    end

    context "with degree_option equivalent" do
      it "sets the correct degree_type_id before validation" do
        equivalent.valid?
        expect(equivalent.degree_type_id).to eq(HaveADegree::DEGREE_TYPE[:equivalent])
      end
    end
  end

end
