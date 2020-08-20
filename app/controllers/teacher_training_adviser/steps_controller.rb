module TeacherTrainingAdviser
  class StepsController < ApplicationController
    include WizardSteps
    self.wizard_class = SignUp::Wizard

  private

    def step_path(step = params[:id])
      teacher_training_adviser_step_path step
    end
    helper_method :step_path

    def wizard_store
      Wizard::Store.new session_store
    end

    def session_store
      session[:sign_up] ||= {}
    end
  end
end
