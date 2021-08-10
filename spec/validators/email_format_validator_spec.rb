require "rails_helper"

RSpec.describe EmailFormatValidator do
  subject { instance.errors }

  let :test_model do
    Class.new do
      include ActiveModel::Model
      attr_accessor :email

      validates :email, email_format: true

      def self.model_name
        ActiveModel::Name.new(self, nil, "test")
      end
    end
  end

  before { instance.valid? }

  context "with invalid addresses" do
    %w[test.com test@@test.com test@test test@test.].each do |email|
      let(:instance) { test_model.new(email: email) }

      it "#{email} should not be valid" do
        expect(subject).to be_added(:email, :invalid)
      end
    end

    context "when over 100 characters" do
      let(:instance) { test_model.new(email: "#{'a' * 100}@test.com") }

      it "is not be valid" do
        expect(subject).to be_added(:email, :too_long)
      end
    end
  end

  context "with valid addresses" do
    %w[test@example.com testymctest@gmail.com test%.mctest@domain.co.uk]
      .each do |email|
      let(:instance) { test_model.new(email: email) }

      it "#{email} should be valid" do
        expect(subject).to be_empty
      end
    end
  end
end
