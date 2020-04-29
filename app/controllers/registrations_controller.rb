class RegistrationsController < ApplicationController

  def new
    session[:registration_params] ||= {}
    @registration = Registration.new(session[:registration_params])
    @registration.current_step = session[:registration_step]
  end

  def create
    #byebug
    session[:registration_params].deep_merge!(params[:registration].to_unsafe_h) if params[:registration]
    @registration = Registration.new(session[:registration_params])
    @registration.current_step = session[:registration_step]
    if @registration.valid?
      if params[:back_button]
        @registration.previous_step
      elsif @registration.last_step?
        @registration.save if @registration.all_valid?
      else
        @registration.next_step
      end
      session[:registration_step] = @registration.current_step
    end
    if @registration.current_step != "completed"
      render "new"
    else
      session[:registration_step] = session[:registration_params] = nil
      flash[:notice] = "Registration saved!"
      redirect_to @registration
    end
  end
  
  private
   
  def registration_params
    params.require(:registration).permit(
    :email,
    :first_name,
    :last_name,
    :returning_to_teaching,
    :have_a_degree, 
    :primary_or_secondary,
    :primary_subject_qualified_to_teach,
    :secondary_subject_qualified_to_teach,
    :date_of_birth)
  end

end