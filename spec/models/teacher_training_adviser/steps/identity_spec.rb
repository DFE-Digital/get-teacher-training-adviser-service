require "rails_helper"

RSpec.describe TeacherTrainingAdviser::Steps::Identity do
  include_context "wizard step"
  it_behaves_like "a wizard step"

  context "attributes" do
    it { is_expected.to respond_to :first_name }
    it { is_expected.to respond_to :last_name }
    it { is_expected.to respond_to :email }
  end

  describe "first_name" do
    it { is_expected.to_not allow_values(nil, "", "a" * 257).for :first_name }
    it { is_expected.to allow_values("John").for :first_name }
  end

  describe "last_name" do
    it { is_expected.to_not allow_values(nil, "", "a" * 257).for :last_name }
    it { is_expected.to allow_values("John").for :last_name }
  end

  describe "email" do
    it { is_expected.to_not allow_values(nil, "", "a@#{"a" * 101}.com").for :email }
    it { is_expected.to allow_values("test@test.com", "test%.mctest@domain.co.uk").for :email }
  end
end
