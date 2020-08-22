module TeacherTrainingAdviser
  class Wizard < ::Wizard::Base
    self.steps = [
      Steps::Identity,
      Steps::ReturningTeacher,
      Steps::HaveADegree,
      Steps::NoDegree,
      Steps::StageOfDegree,
      Steps::WhatSubjectDegree,
      Steps::WhatDegreeClass,
      Steps::StageInterestedTeaching,
      Steps::SubjectInterestedTeaching,
      Steps::GcseMathsEnglish,
      Steps::RetakeGcseMathsEnglish,
      Steps::QualificationRequired,
      Steps::GcseScience,
      Steps::RetakeGcseScience,
      Steps::QualificationRequired,
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

        @store.purge!
      end
    end
  end
end
