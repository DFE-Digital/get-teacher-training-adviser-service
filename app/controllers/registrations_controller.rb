class RegistrationsController < ApplicationController

  def index
  end

  def show
  end

  def new
    @wizard = ModelWizard.new(Registration, session, params).start
    @registration = @wizard.object
  end

  def edit
    #@registration = Registration.find_by(id: params[:id])
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

 # def update
 #   @registration = Registration.find_by(id: params[:id])
 #   @wizard = ModelWizard.new(@registration, session, params, registration_params).continue
 #   if @wizard.save
 #     redirect_to @registration, notice: 'Registration updated.'
 #   else
 #     render :edit
 #   end
 # end
   
  private
   
  def registration_params
    params.require(:registration).permit(
    :email_address,
    :first_name,
    :last_name,
    :returning_to_teaching,
    :current_step
    )
  end

end