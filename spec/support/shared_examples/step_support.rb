RSpec.shared_context "wizard store" do
  let(:wizardstore) { { "name" => "Joe", "age" => 35 } }
end

RSpec.shared_context "wizard step" do
  include_context "wizard store"
  let(:attributes) { {} }
  let(:instance) { described_class.new wizardstore, attributes }
  subject { instance }
end

RSpec.shared_examples "a wizard step" do
  it { is_expected.to respond_to :save! }
end

RSpec.shared_examples "an issue verification code wizard step" do
  let(:wizardstore) { { "name" => "Joe", "age" => 35 } }

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
        expect_any_instance_of(GetIntoTeachingApiClient::CandidatesApi).to_not receive(:create_candidate_access_token)
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
        allow_any_instance_of(GetIntoTeachingApiClient::CandidatesApi).to receive(:create_candidate_access_token).with(request)
          .and_raise(GetIntoTeachingApiClient::ApiError)
        subject.save!
        expect(wizardstore["authenticate"]).to be_falsy
      end
    end
  end
end
