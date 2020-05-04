class RegistrationsController < ApplicationController

  def index
  end

  def show
  end

  def new
    byebug
    @wizard = ModelWizard.new(Registration, session, params).start
    @registration = @wizard.object
    @current_step = params[:current_step]
  end

  def edit
    @registration = Registration.find_by(id: params[:id])
    @wizard = ModelWizard.new(@registration, session, params).start
  end

  def create
    @wizard = ModelWizard.new(Registration, session, params, registration_params).continue
    @registration = @wizard.object
    if @wizard.save
      session[:registration] = @registration.attributes
      if @registration.attributes["returning_to_teaching"]
        redirect_to new_returning_teacher_path(current_step: @current_step)
      else
        #redirect_to another_path
      end
    else
      render :new, current_step: @registration.current_step
    end
  end

  def update
    @registration = Registration.find_by(id: params[:id])
    @wizard = ModelWizard.new(@registration, session, params, registration_params).continue
    if @wizard.save
      redirect_to @registration, notice: 'Registration updated.'
    else
      render :edit
    end
  end
   
  private
   
  def registration_params
    params.require(:registration).permit(
    :email,
    :first_name,
    :last_name,
    :returning_to_teaching,
    :current_step
    )
  end

end