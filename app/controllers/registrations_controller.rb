class RegistrationsController < ApplicationController

  def new
    @wizard = ModelWizard.new(Registration, session, params).start
    @registration = @wizard.object
  end

  def create
    @wizard = ModelWizard.new(Registration, session, params, registration_params).continue
    @registration = @wizard.object
    if @wizard.save
      if @registration.attributes["returning_to_teaching"]
        redirect_to new_returning_teacher_path(step: 0)
      else
        #redirect_to another_path
      end
    else
      redirect_to new_registration_path(step: @registration.current_step)
    end
  end
   
  private
   
  def registration_params
    params.require(:registration).permit(
    :email_address,
    :first_name,
    :last_name,
    :returning_to_teaching,
    :current_step,
    :stage
    )
  end

end