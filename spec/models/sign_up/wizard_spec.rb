require "rails_helper"

RSpec.describe SignUp::Wizard do
  describe ".steps" do
    subject { described_class.steps }

    it do
      is_expected.to eql [
        SignUp::Steps::Identity,
        SignUp::Steps::ReturningTeacher,
        SignUp::Steps::HaveADegree,
        SignUp::Steps::NoDegree,
        SignUp::Steps::StageOfDegree,
        SignUp::Steps::WhatSubjectDegree,
        SignUp::Steps::WhatDegreeClass,
        SignUp::Steps::StageInterestedTeaching,
        SignUp::Steps::GcseMathsEnglish,
        SignUp::Steps::RetakeGcseMathsEnglish,
        SignUp::Steps::QualificationRequired,
        SignUp::Steps::GcseScience,
        SignUp::Steps::RetakeGcseScience,
        SignUp::Steps::QualificationRequired,
        SignUp::Steps::StartTeacherTraining,
        SignUp::Steps::HasTeacherId,
        SignUp::Steps::PreviousTeacherId,
        SignUp::Steps::SubjectTaught,
        SignUp::Steps::SubjectLikeToTeach,
        SignUp::Steps::DateOfBirth,
        SignUp::Steps::UkOrOverseas,
        SignUp::Steps::UkAddress,
        SignUp::Steps::UkTelephone,
        SignUp::Steps::OverseasCountry,
        SignUp::Steps::OverseasTelephone,
        SignUp::Steps::UkCallback,
        SignUp::Steps::OverseasCallback,
        SignUp::Steps::ReviewAnswers,
        SignUp::Steps::AcceptPrivacyPolicy,
      ]
    end
  end

  describe "#complete!" do
    let(:store) do
      {
        "email" => "email@address.com",
        "first_name" => "Joe",
        "last_name" => "Joseph",
      }
    end
    let(:wizardstore) { Wizard::Store.new store }

    subject { described_class.new wizardstore, "accept_privacy_policy" }

    before { allow(subject).to receive(:valid?).and_return true }
    before { subject.complete! }

    it { is_expected.to have_received(:valid?) }
    it { expect(store).to eql({}) }
  end
end
