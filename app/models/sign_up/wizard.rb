module SignUp
  class Wizard < ::Wizard::Base
    self.steps = [
      Steps::Identity,
      Steps::ReturningTeacher,
      Steps::HaveADegree,
      Steps::StageOfDegree,
      Steps::WhatSubjectDegree,
      Steps::WhatDegreeClass,
      Steps::StageInterestedTeaching,
      Steps::GcseMathsEnglish,
      Steps::GcseScience,
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
      Steps::Callback,
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
