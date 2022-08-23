require "rails_helper"

RSpec.describe TeacherTrainingAdviser::Steps::StartTeacherTraining do
  include_context "with a wizard step"
  it_behaves_like "a wizard step"

  describe "attributes" do
    it { is_expected.to respond_to :initial_teacher_training_year_id }
  end

  describe "#initial_teacher_training_year_id" do
    it "allows a valid initial_teacher_training_year_id" do
      year = GetIntoTeachingApiClient::PickListItem.new(id: 12_917)
      allow_any_instance_of(GetIntoTeachingApiClient::PickListItemsApi).to \
        receive(:get_candidate_initial_teacher_training_years) { [year] }
      expect(subject).to allow_value(12_917).for :initial_teacher_training_year_id
    end

    it { is_expected.not_to allow_values("", nil, 456).for :initial_teacher_training_year_id }
  end

  describe "#years" do
    before do
      years = [
        GetIntoTeachingApiClient::PickListItem.new(id: 12_917, value: "Not sure"),
        GetIntoTeachingApiClient::PickListItem.new(id: 12_920, value: 2022),
        GetIntoTeachingApiClient::PickListItem.new(id: 12_921, value: 2023),
        GetIntoTeachingApiClient::PickListItem.new(id: 12_921, value: 2024),
        GetIntoTeachingApiClient::PickListItem.new(id: 12_922, value: 2025),
      ]

      allow_any_instance_of(GetIntoTeachingApiClient::PickListItemsApi).to \
        receive(:get_candidate_initial_teacher_training_years) { years }
    end

    let(:years) { subject.years }

    context "when its before 24th June of the current year (2022)" do
      around do |example|
        travel_to(Date.new(2022, 6, 23)) { example.run }
      end

      it "returns 'Not sure', and the current year plus next 2 years" do
        expect(years.map(&:value)).to contain_exactly(
          "Not sure",
          "2022 - start your training this September",
          "2023",
          "2024",
        )
      end
    end

    context "when its 24th June of the current year (2022)" do
      around do |example|
        travel_to(Date.new(2022, 6, 24)) { example.run }
      end

      it "returns 'Not sure', and the current year plus next 3 years" do
        expect(years.map(&:value)).to contain_exactly(
          "Not sure",
          "2022 - start your training this September",
          "2023",
          "2024",
          "2025",
        )
      end
    end

    context "when its between 24th June and 6th September of the current year (2022)" do
      around do |example|
        travel_to(Date.new(2022, 9, 6)) { example.run }
      end

      it "returns 'Not sure', and the current year plus next 2 years" do
        expect(years.map(&:value)).to contain_exactly(
          "Not sure",
          "2022 - start your training this September",
          "2023",
          "2024",
          "2025",
        )
      end
    end

    context "when its after 6th September of the current year (2022)" do
      around do |example|
        travel_to(Date.new(2022, 9, 7)) { example.run }
      end

      it "returns 'Not sure', and the next 3 years" do
        expect(years.map(&:value)).to contain_exactly(
          "Not sure",
          "2023 - start your training next September",
          "2024",
          "2025",
        )
      end
    end

    context "when its 1st January of the current year (2023)" do
      around do |example|
        travel_to(Date.new(2023, 1, 1)) { example.run }
      end

      it "returns 'Not sure', and the next 3 years" do
        expect(years.map(&:value)).to contain_exactly(
          "Not sure",
          "2023 - start your training this September",
          "2024",
          "2025",
        )
      end
    end
  end

  describe "#skipped?" do
    it "returns false if returning_to_teaching is false" do
      expect_any_instance_of(TeacherTrainingAdviser::Steps::ReturningTeacher).to receive(:returning_to_teaching).and_return(false)
      expect(subject).not_to be_skipped
    end

    it "returns true if returning_to_teaching is true" do
      expect_any_instance_of(TeacherTrainingAdviser::Steps::ReturningTeacher).to receive(:returning_to_teaching).and_return(true)
      expect(subject).to be_skipped
    end
  end

  describe "#reviewable_answers" do
    subject { instance.reviewable_answers }

    let(:pick_list_item) { GetIntoTeachingApiClient::PickListItem.new(id: 12_917, value: "Value") }

    before do
      allow_any_instance_of(GetIntoTeachingApiClient::PickListItemsApi).to \
        receive(:get_candidate_initial_teacher_training_years) { [pick_list_item] }
      instance.initial_teacher_training_year_id = pick_list_item.id
    end

    it { is_expected.to eq({ "initial_teacher_training_year_id" => "Value" }) }

    context "when initial_teacher_training_year_id is nil" do
      before { instance.initial_teacher_training_year_id = nil }

      it { is_expected.to eq({ "initial_teacher_training_year_id" => nil }) }
    end
  end
end
