class PrimariesController < ApplicationController

  def new
    @primary = Primary.new
  end

  def create
    @primary = Primary.new(primary_params)
    if @primary.valid?
      session[:registration].merge!(@primary.attributes)
      redirect_to new_date_of_birth_path
    else
      render :new
    end
  end

  private

  def primary_params
    params.require(:primary).permit(
      :qualified_subject,
    )
  end
  
end