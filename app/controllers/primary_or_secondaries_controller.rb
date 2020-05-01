class PrimaryOrSecondariesController < ApplicationController

  def new
    @primary_or_secondary = PrimaryOrSecondary.new
  end

  def create
    @primary_or_secondary = PrimaryOrSecondary.new(primary_or_secondary_params)
    if @primary_or_secondary.valid?
      session[:registration].merge!(@primary_or_secondary.attributes)
      if @primary_or_secondary.primary_or_secondary == "primary"
        redirect_to new_primary_path
      else
        # redirect to another path
      end
    else
      render :new
    end
  end

  private

  def primary_or_secondary_params
    params.require(:primary_or_secondary).permit(
      :primary_or_secondary
    )
  end
  
end