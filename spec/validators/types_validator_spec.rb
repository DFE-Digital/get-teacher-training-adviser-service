require "rails_helper"

class TypeValidatable
  include ActiveModel::Model

  attr_accessor :type

  validates :type, types: { method: :get_teaching_subjects }
end

RSpec.describe TypesValidator, type: :validator do
  subject { TypeValidatable.new }

  before do
    expect_any_instance_of(GetIntoTeachingApiClient::TypesApi).to \
      receive(:get_teaching_subjects).and_return(
        [OpenStruct.new({ id: 1, value: "one" })],
      )
  end

  it "is invalid when null" do
    expect(subject).to be_invalid
  end

  it "is valid when type in list" do
    subject.type = 1
    expect(subject).to be_valid
  end

  it "is invalid when type not in list" do
    subject.type = 2
    expect(subject).to be_invalid
  end
end
