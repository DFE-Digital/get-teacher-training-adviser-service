class UkCandidatePostcodesController < ApplicationController

  def new
    @uk_candidate_postcode = UkCandidatePostcode.new
  end

  def create
    @uk_candidate_postcode = UkCandidatePostcode.new(uk_candidate_postcode_params)
    if @uk_candidate_postcode.valid?
      session[:registration].merge!(@uk_candidate_postcode.attributes)
      redirect_to new_uk_candidate_address_path
    else
      render :new
    end
  end

  private

  def uk_candidate_postcode_params
    params.require(:uk_candidate_postcode).permit(
      :uk_candidate_postcode,
    )
  end
  
end