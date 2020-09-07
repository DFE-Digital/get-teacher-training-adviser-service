module TeacherTrainingAdviser
  class StepsController < ApplicationController
    include WizardSteps
    self.wizard_class = TeacherTrainingAdviser::Wizard

    around_action :set_time_zone, only: [:show] # rubocop:disable Rails/LexicallyScopedActionFilter
    before_action :set_page_title, only: [:show] # rubocop:disable Rails/LexicallyScopedActionFilter

  private

    def set_time_zone
      old_time_zone = Time.zone
      Time.zone = @wizard.time_zone
      yield
    ensure
      Time.zone = old_time_zone
    end

    def step_path(step = params[:id], params = {})
      teacher_training_adviser_step_path step, params
    end
    helper_method :step_path

    def wizard_store
      ::Wizard::Store.new session_store
    end

    def session_store
      session[:sign_up] ||= {}
    end

    def set_page_title
      @page_title = "#{@current_step.title.downcase} step"
    end
  end
end
