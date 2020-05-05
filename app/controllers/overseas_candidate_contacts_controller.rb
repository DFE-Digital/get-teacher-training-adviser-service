class OverseasCandidateContactsController < ApplicationController

  def new
    @overseas_candidate_contact = OverseasCandidateContact.new
  end

  def create
    @overseas_candidate_contact = OverseasCandidateContact.new(overseas_candidate_contact_params)
    if @overseas_candidate_contact.valid?
      session[:registration].merge!(@overseas_candidate_contact.attributes)
      redirect_to overseas_candidate_confirmation_path
    else
      render :new
    end
  end

  private

  def overseas_candidate_contact_params
    params.require(:overseas_candidate_contact).permit(
      :telephone_number, :callback_date, :callback_time, :email_address
    )
  end
  
end