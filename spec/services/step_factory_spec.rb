require "rails_helper"

RSpec.describe StepFactory do
  subject { described_class }

  describe "#create" do
    context "with a valid constant" do
      it "instantiates the class" do
        expect(subject.create("identity")).to be_an_instance_of(Identity)
      end
    end

    context "with an invalid constant" do
      it "raises a custom NameNotFoundError" do
        expect { subject.create("Invalid") }.to raise_error do |error|
          expect(error).to be_a(StepFactory::NameNotFoundError)
          expect(error.message).to eq("Step name not found for Invalid")
        end
      end
    end
  end
end
