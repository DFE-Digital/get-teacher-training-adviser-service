require "rails_helper"

RSpec.describe TeacherTrainingAdviser::Steps::Identity do
  include_context "with a wizard step"
  before do
    allow_any_instance_of(GetIntoTeachingApiClient::PickListItemsApi).to \
      receive(:get_candidate_teacher_training_adviser_subscription_channels).and_return(channels)
  end

  let(:channels) do
    [
      GetIntoTeachingApiClient::PickListItem.new({ id: 12_345, value: "Channel 1" }),
      GetIntoTeachingApiClient::PickListItem.new({ id: 67_890, value: "Channel 2" }),
    ]
  end

  it_behaves_like "a wizard step"
  include_context "sanitize fields", %i[first_name last_name email]

  it { expect(described_class).to include(::DFEWizard::IssueVerificationCode) }

  it { is_expected.to be_contains_personal_details }

  describe "attributes" do
    it { is_expected.to respond_to :first_name }
    it { is_expected.to respond_to :last_name }
    it { is_expected.to respond_to :email }
  end

  describe "first_name" do
    it { is_expected.not_to allow_values(nil, "", "a" * 257).for :first_name }
    it { is_expected.to allow_values("John").for :first_name }
  end

  describe "last_name" do
    it { is_expected.not_to allow_values(nil, "", "a" * 257).for :last_name }
    it { is_expected.to allow_values("John").for :last_name }
  end

  describe "email" do
    it { is_expected.not_to allow_values(nil, "", "a@#{'a' * 101}.com", "some@thing").for :email }
    it { is_expected.to allow_values("test@test.com", "test%.mctest@domain.co.uk").for :email }
  end

  describe "validations for channel_id" do
    let(:options) { channels.map(&:id) }

    it { is_expected.to allow_values(options).for :channel_id }
    it { is_expected.to allow_value(nil, "").for :channel_id }
    it { is_expected.not_to allow_value(11_233).for :channel_id }
  end

  describe "#reviewable_answers" do
    subject { instance.reviewable_answers }

    before do
      instance.first_name = "John"
      instance.last_name = "Doe"
      instance.email = "john@doe.com"
    end

    it { is_expected.to eq({ "name" => "John Doe", "email" => "john@doe.com" }) }
  end
end
