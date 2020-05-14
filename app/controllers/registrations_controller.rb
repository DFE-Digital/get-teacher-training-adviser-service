class RegistrationsController < ApplicationController

  def new
    byebug
    step_name = params[:step_name].camelize.constantize
    @wizard = ModelWizard.new(step_name, session, params).start
    @registration = @wizard.object
  end

  def create
    byebug
    step_name = params.keys[1]
    class_name = step_name.camelize.constantize
    @wizard = ModelWizard.new(class_name, session, params, params[step_name]).continue
    @registration = @wizard.object
    
    if @registration.valid?
      redirect_to new_registration_path(step_name: @registration.next_step)
    else
     #render :new
      redirect_to new_registration_path(step_name: step_name)
    end
  end

  def registration_params
    byebug
    params.require(:registration).permit(params[step_name].map(&:to_sym))
  end

end