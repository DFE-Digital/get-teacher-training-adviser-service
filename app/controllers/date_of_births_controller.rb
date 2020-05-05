class DateOfBirthsController < ApplicationController

  def new
    @date_of_birth = DateOfBirth.new
  end

  def create
    @date_of_birth = DateOfBirth.new(date_of_birth_params)
    if @date_of_birth.valid?
      session[:registration].merge!(@date_of_birth.attributes)
      redirect_to new_uk_or_oversea_path
    else
      render :new
    end
  end

  private

  def date_of_birth_params
    params.require(:date_of_birth).permit(
      :day, :month, :year
    )
  end
  
end