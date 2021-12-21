module TeacherTrainingAdviser
  class Wizard < ::DFEWizard::Base
    self.steps = [
      Steps::Identity,
      DFEWizard::Steps::Authenticate,
      Steps::AlreadySignedUp,
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
      Steps::SubjectNotFound,
      Steps::DateOfBirth,
      Steps::UkOrOverseas,
      Steps::UkAddress,
      Steps::UkTelephone,
      Steps::OverseasCountry,
      Steps::OverseasTelephone,
      Steps::UkCallback,
      Steps::OverseasTimeZone,
      Steps::OverseasCallback,
      Steps::ReviewAnswers,
      Steps::AcceptPrivacyPolicy,
    ].freeze

    def matchback_attributes
      %i[candidate_id qualification_id adviser_status_id].freeze
    end

    def time_zone
      find(Steps::OverseasTimeZone.key).time_zone || "London"
    end

    def complete!
      return false unless super

      sign_up_candidate

      @store.prune!(leave: %w[type_id degree_options])
    end

    def exchange_access_token(timed_one_time_password, request)
      @api ||= GetIntoTeachingApiClient::TeacherTrainingAdviserApi.new
      @api.exchange_access_token_for_teacher_training_adviser_sign_up(timed_one_time_password, request)
    end

  private

    def sign_up_candidate
      attributes = GetIntoTeachingApiClient::TeacherTrainingAdviserSignUp.attribute_map.keys
      data = export_data.slice(*attributes.map(&:to_s))
      request = GetIntoTeachingApiClient::TeacherTrainingAdviserSignUp.new(data)
      api = GetIntoTeachingApiClient::TeacherTrainingAdviserApi.new
      api.sign_up_teacher_training_adviser_candidate(request)
    end
  end
end
