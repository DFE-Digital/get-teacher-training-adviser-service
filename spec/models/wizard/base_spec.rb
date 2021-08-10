require "rails_helper"

RSpec.describe Wizard::Base do
  include_context "wizard store"

  let(:wizardclass) { TestWizard }
  let(:wizard) { wizardclass.new wizardstore, "age" }

  describe ".indexed_steps" do
    subject { wizardclass.indexed_steps }

    it do
      expect(subject).to eql \
        "name" => TestWizard::Name,
        "age" => TestWizard::Age,
        "other_age" => TestWizard::OtherAge,
        "postcode" => TestWizard::Postcode
    end
  end

  describe ".step" do
    it "will return steps class for valid step" do
      expect(wizardclass.step("age")).to eql TestWizard::Age
    end

    it "will raise exception for unknown step" do
      expect { wizardclass.step("unknown") }.to \
        raise_exception(Wizard::UnknownStep)
    end
  end

  describe ".key_index" do
    it "will return index for known step" do
      expect(wizardclass.key_index("age")).to be 2
    end

    it "will raise exception for unknown step" do
      expect { wizardclass.key_index("unknown") }.to \
        raise_exception(Wizard::UnknownStep)
    end
  end

  describe ".step_keys" do
    subject { wizardclass.step_keys }

    it { is_expected.to eql %w[name other_age age postcode] }
  end

  describe ".first_key" do
    subject { wizardclass.first_key }

    it { is_expected.to eql "name" }
  end

  describe ".new" do
    it "returns instance for known step" do
      expect(wizardclass.new(wizardstore, "name")).to be_instance_of wizardclass
    end

    it "raises exception for unknown step" do
      expect { wizardclass.new wizardstore, "unknown" }.to \
        raise_exception Wizard::UnknownStep
    end
  end

  describe "#access_token_used?" do
    subject { wizard }

    it { is_expected.not_to be_access_token_used }

    context "when auth method is set" do
      before { wizardstore["auth_method"] = described_class::Auth::ACCESS_TOKEN }

      it { is_expected.to be_access_token_used }
    end
  end

  describe "#process_access_token" do
    subject! do
      wizard.process_access_token(token, request)
      wizardstore.fetch(%w[candidate_id first_name last_name email], source: :crm)
    end

    let(:token) { "access-token" }
    let(:request) { GetIntoTeachingApiClient::ExistingCandidateRequest.new }
    let(:stub_response) do
      GetIntoTeachingApiClient::TeacherTrainingAdviserSignUp.new(
        candidateId: "abc123",
        firstName: "John",
        lastName: "Doe",
        email: "john@doe.com",
      )
    end
    let(:response_hash) { stub_response.to_hash.transform_keys { |k| k.to_s.underscore } }

    before do
      allow_any_instance_of(TestWizard).to \
        receive(:exchange_access_token).with(token, request) { stub_response }
    end

    it { is_expected.to eq response_hash }
    it { expect(wizard).to be_access_token_used }

    context "when the wizard does not implement exchange_access_token" do
      before do
        allow_any_instance_of(TestWizard).to \
          receive(:exchange_access_token).with(token, request)
          .and_call_original
      end

      it { expect { wizard.exchange_access_token(token, request) }.to raise_error(Wizard::AccessTokenNotSupportedError) }
    end
  end

  describe "#can_proceed?" do
    subject { wizardclass.new(wizardstore, "name") }

    it { is_expected.to be_can_proceed }
  end

  describe "#current_key" do
    subject { wizardclass.new(wizardstore, "name").current_key }

    it { is_expected.to eql "name" }
  end

  describe "#later_keys" do
    subject { wizardclass.new(wizardstore, "name").later_keys }

    it { is_expected.to eql %w[other_age age postcode] }
  end

  describe "#earlier_keys" do
    subject { wizardclass.new(wizardstore, "postcode").earlier_keys }

    it { is_expected.to eql %w[name other_age age] }
  end

  describe "#find" do
    subject { wizard.find("age") }

    it { is_expected.to be_instance_of TestWizard::Age }
    it { is_expected.to have_attributes age: 35 }
  end

  describe "#find_current_step" do
    subject { wizard.find_current_step }

    it { is_expected.to be_instance_of TestWizard::Age }
  end

  describe "#previous_key" do
    context "when there are earlier steps" do
      subject { wizard.previous_key("age") }

      it { is_expected.to eql "other_age" }
    end

    context "when there are no earlier steps" do
      subject { wizard.previous_key("name") }

      it { is_expected.to be_nil }
    end

    context "when no key supplied" do
      subject { wizard.previous_key }

      it { is_expected.to eql "other_age" }
    end
  end

  describe "#next_key" do
    context "when there are more steps" do
      subject { wizard.next_key("age") }

      it { is_expected.to eql "postcode" }
    end

    context "when there are no more steps" do
      subject { wizard.next_key("postcode") }

      it { is_expected.to be_nil }
    end

    context "when no key supplied" do
      subject { wizard.next_key }

      it { is_expected.to eql "postcode" }
    end
  end

  describe "#valid?" do
    subject { wizard.valid? }

    let(:backingstore) { { "age" => 30, "postcode" => "TE571NG" } }

    before do
      allow_any_instance_of(TestWizard::Name).to \
        receive(:valid?).and_return name_is_valid
    end

    context "when all steps valid" do
      let(:name_is_valid) { true }

      it { is_expected.to be true }
    end

    context "when a step is invalid" do
      let(:name_is_valid) { false }

      it { is_expected.to be false }
    end
  end

  describe "#can_proceed?" do
    subject { wizard.can_proceed? }

    let(:backingstore) { { "age" => 30, "postcode" => "TE571NG" } }

    before do
      allow_any_instance_of(TestWizard::Name).to \
        receive(:can_proceed?).and_return name_can_proceed
    end

    context "when all steps are proceedable" do
      let(:name_can_proceed) { true }

      it { is_expected.to be true }
    end

    context "when a step cannot proceed" do
      let(:name_can_proceed) { false }

      it { is_expected.to be false }
    end
  end

  describe "complete!" do
    subject { wizardclass.new wizardstore, "postcode" }

    before { allow(subject).to receive(:valid?).and_return steps_valid }

    before { allow(subject).to receive(:can_proceed?).and_return steps_can_proceed }

    context "when valid and proceedable" do
      let(:steps_valid) { true }
      let(:steps_can_proceed) { true }

      it { is_expected.to have_attributes complete!: true }
    end

    context "when proceedable but not valid" do
      let(:steps_valid) { false }
      let(:steps_can_proceed) { true }

      it { is_expected.to have_attributes complete!: false }
    end

    context "when valid but not proceedable" do
      let(:steps_valid) { true }
      let(:steps_can_proceed) { false }

      it { is_expected.to have_attributes complete!: false }
    end
  end

  describe "invalid_steps" do
    subject { wizard.invalid_steps.map(&:key) }

    let(:backingstore) { { "age" => 30 } }

    it { is_expected.to eql %w[name postcode] }
  end

  describe "first_invalid_step" do
    subject { wizard.first_invalid_step }

    let(:backingstore) { { "name" => "test" } }

    it { is_expected.to have_attributes key: "age" }
  end

  describe "skipped steps" do
    subject { wizardclass.new wizardstore, current_step }

    before do
      allow_any_instance_of(TestWizard::Age).to \
        receive(:skipped?).and_return true
      allow_any_instance_of(TestWizard::OtherAge).to \
        receive(:skipped?).and_return true
    end

    let(:current_step) { "name" }

    context "for the first step" do
      it { is_expected.to have_attributes first_step?: true }
      it { is_expected.to have_attributes next_key: "postcode" }
    end

    context "for the last step" do
      let(:current_step) { "postcode" }

      it { is_expected.to have_attributes last_step?: true }
      it { is_expected.to have_attributes previous_key: "name" }
    end

    context "when last step skipped" do
      before do
        allow_any_instance_of(TestWizard::Postcode).to \
          receive(:skipped?).and_return true
      end

      it { is_expected.to have_attributes next_key: nil }
      it { is_expected.to have_attributes last_step?: true }
      it { is_expected.to have_attributes first_step?: true }
    end

    context "with invalid steps" do
      subject { wizard.invalid_steps.map(&:key) }

      let(:backingstore) { { "name" => "test" } }

      it { is_expected.to eql %w[postcode] }
    end
  end

  describe "#reviewable_answers_by_step" do
    subject { wizard.reviewable_answers_by_step }

    it { is_expected.to include TestWizard::Name => { "name" => "Joe" } }
    it { is_expected.to include TestWizard::Age => { "age" => 35 } }
    it { is_expected.to include TestWizard::Postcode => { "postcode" => nil } }

    context "with skipped step" do
      before do
        allow_any_instance_of(TestWizard::Age).to \
          receive(:skipped?).and_return true
      end

      it { is_expected.to include TestWizard::Name => { "name" => "Joe" } }
      it { is_expected.not_to include TestWizard::Age => { "age" => 35 } }
      it { is_expected.to include TestWizard::Postcode => { "postcode" => nil } }
    end
  end

  describe "#export_data" do
    subject { wizard.export_data }

    it { is_expected.to include "name" => "Joe" }
    it { is_expected.to include "age" => 35 }
    it { is_expected.to include "postcode" => nil }

    context "with skipped step" do
      before do
        allow_any_instance_of(TestWizard::Name).to \
          receive(:skipped?).and_return true
      end

      it { is_expected.to include "name" => nil }
      it { is_expected.to include "age" => 35 }
      it { is_expected.to include "postcode" => nil }
    end

    context "when a skipped step preceeds a shown step using the same attribute and crm data is present for the field" do
      let(:crm_backingstore) { { "age" => 22 } }
      let(:backingstore) { { "age" => 33 } }

      before do
        allow_any_instance_of(TestWizard::OtherAge).to \
          receive(:skipped?).and_return true
      end

      it { is_expected.to include "age" => 33 }

      context "when exporting the skipped step" do
        it "contains the crm value" do
          skipped_step = wizard.find(TestWizard::OtherAge.key)
          expect(skipped_step.export["age"]).to eq(22)
        end
      end
    end

    context "when the store was populated with matchback data" do
      before do
        wizardstore["candidate_id"] = "abc-123"
        wizardstore["qualification_id"] = "def-456"
        wizardstore["adviser_status_id"] = 123
      end

      it { is_expected.to include "candidate_id" => "abc-123" }
      it { is_expected.to include "qualification_id" => "def-456" }
      it { is_expected.to include "adviser_status_id" => 123 }
    end
  end
end
