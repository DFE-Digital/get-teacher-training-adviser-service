RSpec.shared_context "wizard store" do
  let(:backingstore) { { "name" => "Joe", "age" => 35 } }
  let(:wizardstore) { Wizard::Store.new backingstore }
end

RSpec.shared_context "wizard step" do
  include_context "wizard store"
  let(:attributes) { {} }
  let(:instance) { described_class.new nil, wizardstore, attributes }
  subject { instance }
end

RSpec.shared_examples "a wizard step" do
  it { expect(subject.class).to respond_to :key }
  it { is_expected.to respond_to :save! }
end

RSpec.shared_examples "a wizard step that exposes API types as options" do |api_method, omit_ids|
  it { expect(subject.class).to respond_to :options }

  it "it exposes API types as options" do
    types = [
      GetIntoTeachingApiClient::TypeEntity.new(id: 1, value: "one"),
      GetIntoTeachingApiClient::TypeEntity.new(id: 2, value: "two"),
    ]

    allow_any_instance_of(GetIntoTeachingApiClient::TypesApi).to \
      receive(api_method) { types }

    expect(described_class.options).to eq({ "one" => "1", "two" => "2" })
  end

  if omit_ids
    it "omits options with the ids #{omit_ids}" do
      omitted_types = omit_ids.map { |id| GetIntoTeachingApiClient::TypeEntity.new(id: id, value: "omit-#{id}") }

      allow_any_instance_of(GetIntoTeachingApiClient::TypesApi).to \
        receive(api_method) { omitted_types }

      expect(described_class.options).to be_empty
    end
  end
end

RSpec.shared_examples "an issue verification code wizard step" do
  describe "#save!" do
    before do
      subject.email = "email@address.com"
      subject.first_name = "first"
      subject.last_name = "last"
    end

    let(:request) do
      GetIntoTeachingApiClient::ExistingCandidateRequest.new(
        email: subject.email,
        firstName: subject.first_name,
        lastName: subject.last_name,
      )
    end

    context "when invalid" do
      it "does not call the API" do
        subject.email = nil
        subject.save!
        expect_any_instance_of(GetIntoTeachingApiClient::CandidatesApi).to_not \
          receive(:create_candidate_access_token)
      end
    end

    context "when an existing candidate" do
      before do
        allow_any_instance_of(GetIntoTeachingApiClient::CandidatesApi).to \
          receive(:create_candidate_access_token).with(request)
      end

      it "sends verification code and sets authenticate to true" do
        subject.save!
        expect(wizardstore["authenticate"]).to be_truthy
      end

      it "clears the store if the user previously authenticated" do
        wizardstore["authenticate"] = true
        wizardstore["other_user_data"] = "clear me!"
        subject.save!
        expect(wizardstore["other_user_data"]).to be_nil
      end
    end

    context "when a new candidate or CRM is unavailable" do
      it "will skip the authenticate step" do
        allow_any_instance_of(GetIntoTeachingApiClient::CandidatesApi).to \
          receive(:create_candidate_access_token).with(request)
          .and_raise(GetIntoTeachingApiClient::ApiError)
        subject.save!
        expect(wizardstore["authenticate"]).to be_falsy
      end
    end

    context "when the API rate limits the request" do
      let(:too_many_requests_error) { GetIntoTeachingApiClient::ApiError.new(code: 429) }

      it "will re-raise the ApiError (to be rescued by the ApplicationController)" do
        allow_any_instance_of(GetIntoTeachingApiClient::CandidatesApi).to receive(:create_candidate_access_token).with(request)
          .and_raise(too_many_requests_error)
        expect { subject.save! }.to raise_error(too_many_requests_error)
        expect(wizardstore["authenticate"]).to be_nil
      end
    end
  end
end

class TestWizard < Wizard::Base
  class Name < Wizard::Step
    attribute :name
    validates :name, presence: true
  end

  class Age < Wizard::Step
    attribute :age, :integer
    validates :age, presence: true
  end

  class Postcode < Wizard::Step
    attribute :postcode
    validates :postcode, presence: true
  end

  self.steps = [Name, Age, Postcode].freeze
end
