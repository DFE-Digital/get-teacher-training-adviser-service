require "rails_helper"

RSpec.describe TeacherTrainingAdviser::Steps::OverseasCountry do
  include_context "wizard step"
  it_behaves_like "a wizard step"
  it_behaves_like "a wizard step that exposes API types as options",
                  :get_country_types, described_class::OMIT_COUNTRY_IDS

  context "attributes" do
    it { is_expected.to respond_to :country_id }
  end

  describe "country_id" do
    it "allows a valid country id" do
      country = GetIntoTeachingApiClient::TypeEntity.new(id: "abc-123")
      allow_any_instance_of(GetIntoTeachingApiClient::TypesApi).to \
        receive(:get_country_types) { [country] }
      expect(subject).to allow_value(country.id).for :country_id
    end
    it { is_expected.to_not allow_values(nil, "", "def-123").for :country_id }
  end

  describe "#skipped?" do
    it "returns false if uk_or_overseas is Overseas" do
      wizardstore["uk_or_overseas"] = TeacherTrainingAdviser::Steps::UkOrOverseas::OPTIONS[:overseas]
      expect(subject).to_not be_skipped
    end

    it "returns true if uk_or_overseas is UK" do
      wizardstore["uk_or_overseas"] = TeacherTrainingAdviser::Steps::UkOrOverseas::OPTIONS[:uk]
      expect(subject).to be_skipped
    end
  end

  describe "#reviewable_answers" do
    subject { instance.reviewable_answers }
    let(:type) { GetIntoTeachingApiClient::TypeEntity.new(id: "123", value: "Value") }
    before do
      allow_any_instance_of(GetIntoTeachingApiClient::TypesApi).to \
        receive(:get_country_types) { [type] }
      instance.country_id = type.id
    end

    it { is_expected.to eq({ "country_id" => "Value" }) }
  end
end
