module TeacherTrainingAdviser
  module Steps
    class Authenticate < ::Wizard::Steps::Authenticate
    protected

      def perform_existing_candidate_request(request)
        @api ||= GetIntoTeachingApiClient::TeacherTrainingAdviserApi.new
        @api.exchange_access_token_for_teacher_training_adviser_sign_up(timed_one_time_password, request)
      end
    end
  end
end
