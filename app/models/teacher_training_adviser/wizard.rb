module TeacherTrainingAdviser
  class Wizard < ::DFEWizard::Base
    UK_COUNTRY_ID = "72f5c2e6-74f9-e811-a97a-000d3a2760f2".freeze

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
      Steps::PrimaryReturner,
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

      @store.prune!(leave: %w[type_id degree_options sub_channel_id])
    end

    def exchange_access_token(timed_one_time_password, request)
      @api ||= GetIntoTeachingApiClient::TeacherTrainingAdviserApi.new
      @api.exchange_access_token_for_teacher_training_adviser_sign_up(timed_one_time_password, request)
    end

    def export_data
      super.tap do |export|
        # Default country_id to be UK if applicable
        export["country_id"] = UK_COUNTRY_ID if @store[:uk_or_overseas] == Steps::UkOrOverseas::OPTIONS[:uk]
      end
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
