module TeacherTrainingAdviser
  class StepsController < ApplicationController
    include CircuitBreaker
    include WizardSteps
    self.wizard_class = TeacherTrainingAdviser::Wizard

    around_action :set_time_zone, only: %i[show update] # rubocop:disable Rails/LexicallyScopedActionFilter
    before_action :set_page_title, only: [:show] # rubocop:disable Rails/LexicallyScopedActionFilter

    def completed
      super

      @returner = params[:type_id].to_i == Steps::ReturningTeacher::OPTIONS[:returning_to_teaching]
      @equivalent_degree = params[:degree_options] == Steps::HaveADegree::DEGREE_OPTIONS[:equivalent]
    end

  protected

    def not_available_path
      teacher_training_adviser_not_available_path
    end

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
      ::Wizard::Store.new app_store, crm_store
    end

    def app_store
      session[:sign_up] ||= {}
    end

    def crm_store
      session[:sign_up_crm] ||= {}
    end

    def set_page_title
      @page_title = "#{@current_step.title.downcase} step"
    end
  end
end
