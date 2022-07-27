module TeacherTrainingAdviser
  class StepsController < ApplicationController
    include CircuitBreaker
    include GITWizard::Controller
    self.wizard_class = TeacherTrainingAdviser::Wizard

    around_action :set_time_zone, only: %i[show update] # rubocop:disable Rails/LexicallyScopedActionFilter

    def completed
      super

      @returner = wizard_store[:type_id].to_i == Steps::ReturningTeacher::OPTIONS[:returning_to_teaching]
      @equivalent_degree = wizard_store[:degree_options] == Steps::HaveADegree::DEGREE_OPTIONS[:equivalent]
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
      ::GITWizard::Store.new app_store, crm_store
    end

    def app_store
      session[:sign_up] ||= {}
    end

    def crm_store
      session[:sign_up_crm] ||= {}
    end
  end
end
