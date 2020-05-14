require 'rails_helper'

RSpec.describe 'Identity' do
  let(:identity) { build(:identity) }
  let(:no_name) { build(:identity, first_name: "") }

  describe "validation" do

    context "without required attributes" do
      it "should be invalid" do
        expect(no_name).to_not be_valid
      end

      it "should return error messages" do
        no_name.valid?
        expect(no_name.errors[:first_name]).to eq ["can't be blank"]
      end
    end
  end
end