class RegistrationsController < ApplicationController
  def new
    step_name = params[:step_name]
    @registration = StepFactory.create!(step_name)
  rescue StepFactory::NameNotFoundError => e
    # needs to redirect to root or last valid step
    redirect_to :root, alert: "Error: #{e.message}"
  end

  def create
    step_name = params[:step_name]
    @registration = StepFactory.create!(step_name)
    @registration.assign_attributes(registration_params)

    if @registration.valid?
      update_session_registration_hash
      redirect_to new_registration_path(step_name: @registration.next_step)
    else
      render :new
    end
  end

private

  def update_session_registration_hash
    session[:registration] ||= {}
    session[:registration].merge!(@registration.attributes)
  end

  def entity_name
    # check for namespaces
    @registration.step_name.gsub("/", "_").to_sym
  end

  def registration_params
    if params[entity_name]
      params.require(entity_name).permit(params[entity_name].keys.map(&:to_sym))
    else
      {}
    end
  end
end
