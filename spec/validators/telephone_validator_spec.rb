require "rails_helper"

RSpec.describe TelephoneValidator do
  class TelephoneTestModel
    include ActiveModel::Model
    attr_accessor :telephone
    validates :telephone, telephone: true
  end

  before { instance.valid? }
  subject { instance.errors.to_h }

  context "when too short" do
    let(:instance) { TelephoneTestModel.new(telephone: "123") }
    it { is_expected.to include telephone: "Telephone number is too short (minimum is 5 characters)" }
  end

  context "when too long" do
    let(:instance) { TelephoneTestModel.new(telephone: "1" * 21) }
    it { is_expected.to include telephone: "Telephone number is too long (maximum is 20 characters)" }
  end

  context "when invalid format" do
    let(:instance) { TelephoneTestModel.new(telephone: "abc123") }
    it { is_expected.to include telephone: "Enter a telephone number in the correct format" }
  end
end
