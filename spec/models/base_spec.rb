require "rails_helper"

module StepSection
  class StubStep < Base
    attribute :name, :string
  end
end

RSpec.describe Base do
  let(:step) { StepSection::StubStep.new }

  describe "#step_name" do
    subject { step.step_name }

    it { is_expected.to eq("step_section/stub_step") }
  end

  describe "#to_partial_path" do
    subject { step.to_partial_path }

    it { is_expected.to eq("registrations/step_section/stub_step") }
  end

  describe "save" do
    it "merges the store with the model attributes" do
      store = { "name" => "Josh", "age" => 10 }
      step.name = "James"
      step.save!(store)
      expect(store).to eq({ "name" => "James", "age" => 10 })
    end
  end
end
