RSpec.shared_context "wizard store" do
  let(:backingstore) { { "name" => "Joe", "age" => 35 } }
  let(:crm_backingstore) { {} }
  let(:wizardstore) { Wizard::Store.new backingstore, crm_backingstore }
end

RSpec.shared_context "wizard step" do
  include_context "wizard store"
  let(:attributes) { {} }
  let(:wizard) { TeacherTrainingAdviser::Wizard.new(wizardstore, described_class.key) }
  let(:instance) do
    described_class.new wizard, wizardstore, attributes
  end
  subject { instance }
end

RSpec.shared_examples "a wizard step" do
  it { expect(subject.class).to respond_to :key }
  it { is_expected.to respond_to :save! }
end

RSpec.shared_examples "a wizard step that exposes API pick list items as options" do |api_method, omit_ids, include_ids|
  let(:pick_list_items) do
    [
      GetIntoTeachingApiClient::PickListItem.new(id: 1, value: "one"),
      GetIntoTeachingApiClient::PickListItem.new(id: 2, value: "two"),
    ]
  end
  let(:pick_list_item_ids) { pick_list_items.map(&:id) }

  it { expect(subject.class).to respond_to :options }

  unless include_ids
    it "it exposes API pick list items as options" do
      allow_any_instance_of(GetIntoTeachingApiClient::PickListItemsApi).to \
        receive(api_method) { pick_list_items }

      expect(described_class.options.values).to eq(pick_list_item_ids)
    end
  end

  if omit_ids
    it "omits options with the ids #{omit_ids}" do
      omitted_pick_list_items = omit_ids.map { |id| GetIntoTeachingApiClient::PickListItem.new(id: id, value: "omit-#{id}") }

      allow_any_instance_of(GetIntoTeachingApiClient::PickListItemsApi).to \
        receive(api_method) { omitted_pick_list_items + pick_list_items }

      expect(described_class.options.values).to eq(pick_list_item_ids)
    end
  end

  if include_ids
    it "includes only options with the ids #{include_ids}" do
      included_pick_list_items = include_ids.map { |id| GetIntoTeachingApiClient::PickListItem.new(id: id, value: "include-#{id}") }
      included_pick_list_item_ids = included_pick_list_items.map(&:id)

      allow_any_instance_of(GetIntoTeachingApiClient::PickListItemsApi).to \
        receive(api_method) { included_pick_list_items + pick_list_items }

      expect(described_class.options.values).to eq(included_pick_list_item_ids)
    end
  end
end

RSpec.shared_examples "a wizard step that exposes API lookup items as options" do |api_method, omit_ids, include_ids|
  let(:lookup_items) do
    [
      GetIntoTeachingApiClient::LookupItem.new(id: "1", value: "one"),
      GetIntoTeachingApiClient::LookupItem.new(id: "2", value: "two"),
    ]
  end
  let(:lookup_item_ids) { lookup_items.map(&:id) }

  it { expect(subject.class).to respond_to :options }

  unless include_ids
    it "it exposes API lookup items as options" do
      allow_any_instance_of(GetIntoTeachingApiClient::LookupItemsApi).to \
        receive(api_method) { lookup_items }

      expect(described_class.options.values).to eq(lookup_item_ids)
    end
  end

  if omit_ids
    it "omits options with the ids #{omit_ids}" do
      omitted_lookup_items = omit_ids.map { |id| GetIntoTeachingApiClient::LookupItem.new(id: id, value: "omit-#{id}") }

      allow_any_instance_of(GetIntoTeachingApiClient::LookupItemsApi).to \
        receive(api_method) { omitted_lookup_items + lookup_items }

      expect(described_class.options.values).to eq(lookup_item_ids)
    end
  end

  if include_ids
    it "includes only options with the ids #{include_ids}" do
      included_lookup_items = include_ids.map { |id| GetIntoTeachingApiClient::LookupItem.new(id: id, value: "include-#{id}") }
      included_lookup_item_ids = included_lookup_items.map(&:id)

      allow_any_instance_of(GetIntoTeachingApiClient::LookupItemsApi).to \
        receive(api_method) { included_lookup_items + lookup_items }

      expect(described_class.options.values).to eq(included_lookup_item_ids)
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

    it "purges previous data from the store" do
      allow_any_instance_of(GetIntoTeachingApiClient::CandidatesApi).to receive(:create_candidate_access_token).with(request)
      wizardstore["candidate_id"] = "abc123"
      wizardstore["extra_data"] = "data"
      subject.save!
      expect(wizardstore.to_hash).to eq(subject.attributes.merge({ "authenticate" => true }))
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
