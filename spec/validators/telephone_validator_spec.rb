require "rails_helper"

RSpec.describe TelephoneValidator do
  class TelephoneTestModel
    include ActiveModel::Model
    attr_accessor :telephone
    validates :telephone, telephone: true
  end

  before { instance.valid? }
  subject { instance.errors.details[:telephone] }

  context "when too short" do
    let(:instance) { TelephoneTestModel.new(telephone: "123") }
    it { is_expected.to include error: :too_short }
  end

  context "when too long" do
    let(:instance) { TelephoneTestModel.new(telephone: "1" * 21) }
    it { is_expected.to include error: :too_long }
  end

  context "when invalid format" do
    let(:instance) { TelephoneTestModel.new(telephone: "abc123") }
    it { is_expected.to include error: :invalid }
  end
end
