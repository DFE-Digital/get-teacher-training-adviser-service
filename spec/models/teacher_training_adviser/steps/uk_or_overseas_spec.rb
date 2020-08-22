require "rails_helper"

RSpec.describe TeacherTrainingAdviser::Steps::UkOrOverseas do
  include_context "wizard step"
  it_behaves_like "a wizard step"

  context "attributes" do
    it { is_expected.to respond_to :uk_or_overseas }
    it { is_expected.to respond_to :country_id }
  end

  describe "#uk_or_overseas" do
    it { is_expected.to_not allow_value("").for :uk_or_overseas }
    it { is_expected.to_not allow_value(nil).for :uk_or_overseas }
    it { is_expected.to_not allow_value("Denmark").for :uk_or_overseas }
    it { is_expected.to allow_values(*TeacherTrainingAdviser::Steps::UkOrOverseas::OPTIONS.values).for :uk_or_overseas }
  end

  describe "#country_id" do
    it "allows a valid country_id" do
      country = GetIntoTeachingApiClient::TypeEntity.new(id: "abc-123")
      allow_any_instance_of(GetIntoTeachingApiClient::TypesApi).to \
        receive(:get_country_types) { [country] }
      expect(subject).to allow_value(country.id).for :country_id
    end

    it { is_expected.to allow_values(nil).for :country_id }
    it { is_expected.to_not allow_value("").for :country_id }
  end

  describe "#uk_or_overseas=" do
    it "sets country_id when UK" do
      country = GetIntoTeachingApiClient::TypeEntity.new(id: "abc-123", value: "United Kingdom")
      allow_any_instance_of(GetIntoTeachingApiClient::TypesApi).to \
        receive(:get_country_types) { [country] }

      subject.uk_or_overseas = TeacherTrainingAdviser::Steps::UkOrOverseas::OPTIONS[:uk]
      expect(subject.country_id).to eq(country.id)
    end

    it "does nothing when overseas" do
      subject.uk_or_overseas = TeacherTrainingAdviser::Steps::UkOrOverseas::OPTIONS[:overseas]
      expect(subject.country_id).to be_nil
    end
  end
end
