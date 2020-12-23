require "rails_helper"

RSpec.describe TeacherTrainingAdviser::Wizard do
  describe ".steps" do
    subject { described_class.steps }

    it do
      is_expected.to eql [
        TeacherTrainingAdviser::Steps::Identity,
        TeacherTrainingAdviser::Steps::Authenticate,
        TeacherTrainingAdviser::Steps::AlreadySignedUp,
        TeacherTrainingAdviser::Steps::ReturningTeacher,
        TeacherTrainingAdviser::Steps::HaveADegree,
        TeacherTrainingAdviser::Steps::NoDegree,
        TeacherTrainingAdviser::Steps::StageOfDegree,
        TeacherTrainingAdviser::Steps::WhatSubjectDegree,
        TeacherTrainingAdviser::Steps::WhatDegreeClass,
        TeacherTrainingAdviser::Steps::StageInterestedTeaching,
        TeacherTrainingAdviser::Steps::GcseMathsEnglish,
        TeacherTrainingAdviser::Steps::RetakeGcseMathsEnglish,
        TeacherTrainingAdviser::Steps::GcseScience,
        TeacherTrainingAdviser::Steps::RetakeGcseScience,
        TeacherTrainingAdviser::Steps::QualificationRequired,
        TeacherTrainingAdviser::Steps::SubjectInterestedTeaching,
        TeacherTrainingAdviser::Steps::StartTeacherTraining,
        TeacherTrainingAdviser::Steps::HasTeacherId,
        TeacherTrainingAdviser::Steps::PreviousTeacherId,
        TeacherTrainingAdviser::Steps::SubjectTaught,
        TeacherTrainingAdviser::Steps::SubjectLikeToTeach,
        TeacherTrainingAdviser::Steps::SubjectNotFound,
        TeacherTrainingAdviser::Steps::DateOfBirth,
        TeacherTrainingAdviser::Steps::UkOrOverseas,
        TeacherTrainingAdviser::Steps::UkAddress,
        TeacherTrainingAdviser::Steps::UkTelephone,
        TeacherTrainingAdviser::Steps::OverseasCountry,
        TeacherTrainingAdviser::Steps::OverseasTelephone,
        TeacherTrainingAdviser::Steps::UkCallback,
        TeacherTrainingAdviser::Steps::OverseasTimeZone,
        TeacherTrainingAdviser::Steps::ReviewAnswers,
        TeacherTrainingAdviser::Steps::AcceptPrivacyPolicy,
      ]
    end
  end

  describe "instance methods" do
    let(:store) do
      {
        "email" => "email@address.com",
        "first_name" => "Joe",
        "last_name" => "Joseph",
      }
    end
    let(:wizardstore) { Wizard::Store.new store }

    subject { described_class.new wizardstore, "accept_privacy_policy" }

    describe "#time_zone" do
      it "defaults to London" do
        expect(subject.time_zone).to eq("London")
      end
    end

    describe "#complete!" do
      let(:request) do
        GetIntoTeachingApiClient::TeacherTrainingAdviserSignUp.new(
          { email: "email@address.com", firstName: "Joe", lastName: "Joseph" },
        )
      end

      before do
        expect_any_instance_of(GetIntoTeachingApiClient::TeacherTrainingAdviserApi).to \
          receive(:sign_up_teacher_training_adviser_candidate).with(request).once
      end
      before { allow(subject).to receive(:valid?).and_return true }
      before { allow(subject).to receive(:can_proceed?).and_return true }
      before { subject.complete! }

      it { is_expected.to have_received(:valid?) }
      it { is_expected.to have_received(:can_proceed?) }
      it { expect(store).to eql({}) }
    end
  end
end
