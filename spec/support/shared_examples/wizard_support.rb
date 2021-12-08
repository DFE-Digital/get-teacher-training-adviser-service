RSpec.shared_context "wizard store" do
  let(:backingstore) { { "name" => "Joe", "age" => 35 } }
  let(:crm_backingstore) { {} }
  let(:wizardstore) { DFEWizard::Store.new backingstore, crm_backingstore }
end

RSpec.shared_context "wizard step" do
  subject { instance }

  include_context "wizard store"
  let(:attributes) { {} }
  let(:wizard) { TeacherTrainingAdviser::Wizard.new(wizardstore, described_class.key) }
  let(:instance) do
    described_class.new wizard, wizardstore, attributes
  end
end

RSpec.shared_examples "a wizard step" do
  it { expect(subject.class).to respond_to :key }
  it { is_expected.to respond_to :save }
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
    it "exposes API pick list items as options" do
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
    it "exposes API lookup items as options" do
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

class TestWizard < DFEWizard::Base
  class Name < DFEWizard::Step
    attribute :name
    validates :name, presence: true
  end

  # To simulate two steps writing to the same attribute.
  class OtherAge < DFEWizard::Step
    attribute :age, :integer
    validates :age, presence: false
  end

  class Age < DFEWizard::Step
    attribute :age, :integer
    validates :age, presence: true
  end

  class Postcode < DFEWizard::Step
    attribute :postcode
    validates :postcode, presence: true
  end

  self.steps = [Name, OtherAge, Age, Postcode].freeze
end
