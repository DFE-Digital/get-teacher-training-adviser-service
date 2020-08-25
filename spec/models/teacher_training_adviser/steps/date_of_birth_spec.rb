require "rails_helper"

RSpec.describe TeacherTrainingAdviser::Steps::DateOfBirth do
  include_context "wizard step"
  it_behaves_like "a wizard step"

  context "attributes" do
    it { is_expected.to respond_to :date_of_birth }
    it { is_expected.to respond_to "date_of_birth(3i)" }
    it { is_expected.to respond_to "date_of_birth(2i)" }
    it { is_expected.to respond_to "date_of_birth(1i)" }
  end

  describe "date_of_birth" do
    it { is_expected.to_not allow_value(nil).for :date_of_birth }
    it { is_expected.to_not allow_value(Date.new(1900, 1, 1)).for :date_of_birth }
    it { is_expected.to_not allow_value(1.year.from_now).for :date_of_birth }
    it { is_expected.to allow_value(18.years.ago).for :date_of_birth }
  end

  it "maps individual components to date_of_birth" do
    subject.send("date_of_birth(1i)=", 2001)
    subject.send("date_of_birth(2i)=", 4)
    subject.send("date_of_birth(3i)=", 20)
    subject.valid?
    expect(subject.date_of_birth).to eq(Date.new(2001, 4, 20))
  end

  describe "#reviewable_answers" do
    subject { instance.reviewable_answers }
    before { instance.date_of_birth = Date.new(1986, 3, 12) }
    it { is_expected.to eq({ "date_of_birth" => "12 03 1986" }) }
  end
end
