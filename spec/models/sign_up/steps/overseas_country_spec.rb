require "rails_helper"

RSpec.describe SignUp::Steps::OverseasCountry do
  include_context "wizard step"
  it_behaves_like "a wizard step"

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
    it { is_expected.to_not allow_value(nil).for :country_id }
    it { is_expected.to_not allow_value("").for :country_id }
  end
end
