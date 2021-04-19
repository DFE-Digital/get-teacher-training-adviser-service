module TeacherTrainingAdviser
  class FeedbacksController < ApplicationController
    def new
      @page_title = "Give feedback on this service"
      @feedback = Feedback.new
    end

    def create
      @feedback = Feedback.new(feedback_params)

      if @feedback.save
        ActiveSupport::Notifications.instrument("tta.feedback", @feedback)
        redirect_to(thank_you_teacher_training_adviser_feedbacks_path)
      else
        render :new
      end
    end

    def thank_you
      @page_title = "Thank you for your feedback"
    end

  private

    def feedback_params
      params.require(:teacher_training_adviser_feedback).permit(
        :rating,
        :improvements,
        :successful_visit,
        :unsuccessful_visit_explanation,
      )
    end
  end
end
