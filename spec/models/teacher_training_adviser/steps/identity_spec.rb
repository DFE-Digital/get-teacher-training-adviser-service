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

  it { expect(described_class).to include(::GITWizard::IssueVerificationCode) }

  it { is_expected.to be_contains_personal_details }

  describe "attributes" do
    it { is_expected.to respond_to :first_name }
    it { is_expected.to respond_to :last_name }
    it { is_expected.to respond_to :email }
    it { is_expected.to respond_to :accepted_policy_id }
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

  describe "#accepted_policy_id" do
    it { is_expected.to allow_value("0a203956-e935-ea11-a813-000d3a44a8e9").for :accepted_policy_id }
    it { is_expected.not_to allow_value("invalid-id").for :accepted_policy_id }
  end

  describe "#export" do
    subject { instance.export }

    %i[channel_id email first_name last_name].each do |key|
      it { is_expected.to have_key(key.to_s) }
    end

    it { is_expected.not_to have_key("sub_channel_id") }
  end

  describe "#save" do
    it "clears the channel_id on save when invalid" do
      subject.channel_id = "invalid"
      subject.save
      expect(subject.channel_id).to be_nil
    end

    it "retains the channel_id on save when valid" do
      subject.channel_id = channels.first.id
      subject.save
      expect(subject.channel_id).to eq(channels.first.id)
    end
  end

  describe "#latest_privacy_policy" do
    subject { instance.latest_privacy_policy }

    let(:policy) { GetIntoTeachingApiClient::PrivacyPolicy.new(id: "abc-123", text: "Latest privacy policy") }

    before do
      allow_any_instance_of(GetIntoTeachingApiClient::PrivacyPoliciesApi).to \
        receive(:get_latest_privacy_policy).and_return(policy)
    end

    it { is_expected.to eq(policy) }
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
