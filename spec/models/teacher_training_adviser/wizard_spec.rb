require "rails_helper"

RSpec.describe TeacherTrainingAdviser::Wizard do
  describe ".steps" do
    subject { described_class.steps }

    it do
      is_expected.to eql [
        TeacherTrainingAdviser::Steps::Identity,
        ::Wizard::Steps::Authenticate,
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
        TeacherTrainingAdviser::Steps::OverseasCallback,
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
        "type_id" => 123,
        "degree_options" => "equivalent",
      }
    end
    let(:wizardstore) { Wizard::Store.new store, {} }

    subject { described_class.new wizardstore, "accept_privacy_policy" }

    describe "#time_zone" do
      it "defaults to London" do
        expect(subject.time_zone).to eq("London")
      end

      it "returns the time_zone from the store" do
        wizardstore["time_zone"] = "Hawaii"
        expect(subject.time_zone).to eq("Hawaii")
      end
    end

    describe "#complete!" do
      let(:request) do
        GetIntoTeachingApiClient::TeacherTrainingAdviserSignUp.new({
          email: "email@address.com",
          firstName: "Joe",
          lastName: "Joseph",
          typeId: 123,
          degreeOptions: "equivalent",
        })
      end

      before do
        expect_any_instance_of(GetIntoTeachingApiClient::TeacherTrainingAdviserApi).to \
          receive(:sign_up_teacher_training_adviser_candidate).with(request).once

        allow(subject).to receive(:valid?) { true }
        allow(subject).to receive(:can_proceed?) { true }

        subject.complete!
      end

      it { is_expected.to have_received(:valid?) }
      it { is_expected.to have_received(:can_proceed?) }
      it { expect(store).to eql({}) }
      it "sets the completion attributes" do
        expect(subject.completion_attributes).to eq({
          "type_id" => 123,
          "degree_options" => "equivalent",
        })
      end
    end

    describe "#exchange_access_token" do
      let(:totp) { "123456" }
      let(:request) { GetIntoTeachingApiClient::ExistingCandidateRequest.new }
      let(:response) { GetIntoTeachingApiClient::TeacherTrainingAdviserSignUp.new }

      before do
        expect_any_instance_of(GetIntoTeachingApiClient::TeacherTrainingAdviserApi).to \
          receive(:exchange_access_token_for_teacher_training_adviser_sign_up)
          .with(totp, request) { response }
      end

      it "calls exchange_access_token_for_teacher_training_adviser_sign_up" do
        expect(subject.exchange_access_token(totp, request)).to eq(response)
      end
    end
  end
end
