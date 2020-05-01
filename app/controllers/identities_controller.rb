class IdentitiesController < ApplicationController

  def new
    @identity = Identity.new
  end

  def create
    @identity = Identity.new(identity_params)
    if @identity.valid?
      session[:registration] = @identity.attributes
      redirect_to new_returning_to_teaching_path
    else
      render :new
    end
  end

  private

  def identity_params
    params.require(:identity).permit(
      :email_address,
      :first_name,
      :last_name
    )
  end
  
end