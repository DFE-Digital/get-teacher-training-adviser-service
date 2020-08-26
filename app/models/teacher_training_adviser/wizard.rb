module TeacherTrainingAdviser
  class Wizard < ::Wizard::Base
    include ::Wizard::ApiClientSupport

    self.steps = [
      Steps::Identity,
      Steps::Authenticate,
      Steps::ReturningTeacher,
      Steps::HaveADegree,
      Steps::NoDegree,
      Steps::StageOfDegree,
      Steps::WhatSubjectDegree,
      Steps::WhatDegreeClass,
      Steps::StageInterestedTeaching,
      Steps::GcseMathsEnglish,
      Steps::RetakeGcseMathsEnglish,
      Steps::GcseScience,
      Steps::RetakeGcseScience,
      Steps::QualificationRequired,
      Steps::SubjectInterestedTeaching,
      Steps::StartTeacherTraining,
      Steps::HasTeacherId,
      Steps::PreviousTeacherId,
      Steps::SubjectTaught,
      Steps::SubjectLikeToTeach,
      Steps::DateOfBirth,
      Steps::UkOrOverseas,
      Steps::UkAddress,
      Steps::UkTelephone,
      Steps::OverseasCountry,
      Steps::OverseasTelephone,
      Steps::UkCallback,
      Steps::OverseasCallback,
      Steps::ReviewAnswers,
      Steps::AcceptPrivacyPolicy,
    ].freeze

    def complete!
      super.tap do |result|
        break unless result

        sign_up_candidate
        @store.purge!
      end
    end

  private

    def sign_up_candidate
      request = GetIntoTeachingApiClient::TeacherTrainingAdviserSignUp.new(export_camelized_hash)
      api = GetIntoTeachingApiClient::TeacherTrainingAdviserApi.new
      api.sign_up_teacher_training_adviser_candidate(request)
    end
  end
end
