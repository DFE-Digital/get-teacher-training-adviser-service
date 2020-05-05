class UkOrOverseasController < ApplicationController

  def new
    @uk_or_oversea = UkOrOversea.new
  end

  def create
    @uk_or_oversea = UkOrOversea.new(uk_or_oversea_params)
    if @uk_or_oversea.valid?
      session[:registration].merge!(@uk_or_oversea.attributes)
      byebug
      if @uk_or_oversea.uk_or_oversea == "uk"
        redirect_to new_uk_candidate_postcode_path
      else
        redirect_to new_overseas_candidate_contact_path
      end
    else
      render :new
    end
  end

  private

  def uk_or_oversea_params
    params.require(:uk_or_oversea).permit(
      :uk_or_oversea,
    )
  end
  
end