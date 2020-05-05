class OverseasCandidateConfirmationsController < ApplicationController

  def new
    @overseas_candidate_confirmation = OverseasCandidateConfirmation.new
  end

  def confirmation
    #@overseas_candidate_confirmation = OverseasCandidateConfirmation.new
  end

  def create
    byebug
    required_params = OverseasCandidateConfirmation.new().attributes.keys
    required_params_hash = session[:registration].slice *required_params
    
    @overseas_candidate_confirmation = OverseasCandidateConfirmation.new(required_params_hash)
    if @overseas_candidate_confirmation.valid?
      session[:registration] = required_params_hash
      redirect_to new_opt_in_emails_path
    else
      # redirect to start?
      render :new
    end
  end

  private

  def overseas_candidate_confirmation_params
   # params.require(:overseas_candidate_confirmation).permit(
   #   :telephone_number, :callback_date, :callback_time, :email_address
   # )
  end
  
end