require "rails_helper"

RSpec.describe TeacherTrainingAdviser::Steps::StartTeacherTraining do
  include_context "wizard step"
  it_behaves_like "a wizard step"

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

    it { is_expected.to_not allow_values("", nil, 456).for :initial_teacher_training_year_id }
  end

  describe "#year_range" do
    before do
      years = [
        GetIntoTeachingApiClient::TypeEntity.new(id: 12_917, value: "Not sure"),
        GetIntoTeachingApiClient::TypeEntity.new(id: 12_918, value: 2020),
        GetIntoTeachingApiClient::TypeEntity.new(id: 12_919, value: 2021),
        GetIntoTeachingApiClient::TypeEntity.new(id: 12_920, value: 2022),
        GetIntoTeachingApiClient::TypeEntity.new(id: 12_921, value: 2023),
        GetIntoTeachingApiClient::TypeEntity.new(id: 12_921, value: 2024),
      ]

      allow_any_instance_of(GetIntoTeachingApiClient::TypesApi).to \
        receive(:get_candidate_initial_teacher_training_years) { years }
    end

    let(:years) { subject.year_range }

    context "when its on or before 17th September of the current year" do
      around do |example|
        travel_to(Date.new(2020, 9, 17)) { example.run }
      end

      it "returns 'Not sure', and the current year plus next 2 years" do
        expect(years.map(&:value)).to eq(["Not sure", 2020, 2021, 2022])
      end
    end

    context "when its after 17th September of the current year" do
      around do |example|
        travel_to(Date.new(2020, 9, 18)) { example.run }
      end

      it "returns 'Not sure', and the next 3 years" do
        expect(years.map(&:value)).to eq(["Not sure", 2021, 2022, 2023])
      end
    end
  end

  describe "#not_sure?" do
    it "returns true if the set year is 'Dont know'" do
      subject.initial_teacher_training_year_id = TeacherTrainingAdviser::Steps::StartTeacherTraining::NOT_SURE_ID
      expect(subject.not_sure?).to be_truthy
    end

    it "returns false if the set year is not 'Dont know'" do
      subject.initial_teacher_training_year_id = -1
      expect(subject.not_sure?).to be_falsy
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

  describe "#reviewable_answers" do
    subject { instance.reviewable_answers }
    let(:type) { GetIntoTeachingApiClient::TypeEntity.new(id: 12_917, value: "Value") }
    before do
      allow_any_instance_of(GetIntoTeachingApiClient::TypesApi).to \
        receive(:get_candidate_initial_teacher_training_years) { [type] }
      instance.initial_teacher_training_year_id = type.id
    end

    it { is_expected.to eq({ "initial_teacher_training_year_id" => "Value" }) }

    context "when initial_teacher_training_year_id is nil" do
      before { instance.initial_teacher_training_year_id = nil }
      it { is_expected.to eq({ "initial_teacher_training_year_id" => nil }) }
    end
  end
end
