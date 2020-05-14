require 'rails_helper'

RSpec.describe StepFactory do
  subject { described_class }

  describe "#create" do
    context "with a valid constant" do
      it "instantiates the class" do
        expect(subject.create("Identity")).to be_an_instance_of(Identity)
      end
    end

    context "with an invalid constant" do
      it "raises a NameError" do
        expect { subject.create("Invalid") }.to raise_error(NameError)
      end
    end
    
  end
  
end