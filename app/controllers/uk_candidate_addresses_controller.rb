class UkCandidateAddressesController < ApplicationController

  def new
    @uk_candidate_address = UkCandidateAddress.new
  end

  def create
    @uk_candidate_address = UkCandidateAddress.new(uk_candidate_address_params)
    if @uk_candidate_address.valid?
      session[:registration].merge!(@uk_candidate_address.attributes)
      redirect_to new_uk_candidate_confirmation_path
    else
      render :new
    end
  end

  private

  def uk_candidate_address_params
    params.require(:uk_candidate_address).permit(
      :address_line_1,
      :address_line_2,
      :postcode,
      :town_city
    )
  end
  
end