require "rails_helper"

RSpec.describe SignUp::Steps::StartTeacherTraining do
  include_context "wizard step"
  it_behaves_like "a wizard step"
  it_behaves_like "a wizard step that exposes API types as options", :get_candidate_initial_teacher_training_years

  context "attributes" do
    it { is_expected.to respond_to :initial_teacher_training_year_id }
  end

  describe "#initial_teacher_training_year_id" do
    it "allows a valid initial_teacher_training_year_id" do
      year = GetIntoTeachingApiClient::TypeEntity.new(id: 12_917)
      allow_any_instance_of(GetIntoTeachingApiClient::TypesApi).to \
        receive(:get_candidate_initial_teacher_training_years) { [year] }
      expect(subject).to allow_value(12_917).for :initial_teacher_training_year_id
    end

    it { is_expected.to_not allow_values("", nil, 1.year.ago.year).for :initial_teacher_training_year_id }
  end

  describe "#year_range" do
    before do
      year1 = GetIntoTeachingApiClient::TypeEntity.new(id: 12_917, value: "Not sure")
      year2 = GetIntoTeachingApiClient::TypeEntity.new(id: 12_918, value: 2020)
      year3 = GetIntoTeachingApiClient::TypeEntity.new(id: 12_919, value: 2021)
      year4 = GetIntoTeachingApiClient::TypeEntity.new(id: 12_920, value: 2022)
      allow_any_instance_of(GetIntoTeachingApiClient::TypesApi).to \
        receive(:get_candidate_initial_teacher_training_years) { [year1, year2, year3, year4] }
    end

    let(:years) { subject.year_range(1) }

    it "returns 'Not sure', the current year and the next year" do
      expect(years.map(&:value)).to eq(["Not sure", 2020, 2021])
    end
  end

  describe "#dont_know" do
    it "returns true if the set year is 'Dont know'" do
      subject.initial_teacher_training_year_id = StartTeacherTraining.options["Not sure"]
      expect(subject.dont_know).to be_truthy
    end

    it "returns false if the set year is not 'Dont know'" do
      subject.initial_teacher_training_year_id = -1
      expect(subject.dont_know).to be_falsy
    end
  end

  describe "#skipped?" do
    it "returns false if returning_to_teaching is false" do
      wizardstore["returning_to_teaching"] = false
      expect(subject).to_not be_skipped
    end

    it "returns true if returning_to_teaching is true" do
      wizardstore["returning_to_teaching"] = true
      expect(subject).to be_skipped
    end
  end
end
