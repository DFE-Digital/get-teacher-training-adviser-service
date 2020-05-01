class ReturningTeachersController < ApplicationController

  def new
    @wizard = ModelWizard.new(ReturningTeacher, session, params).start
    @returning_teacher = @wizard.object
  end

  def create
    @wizard = ModelWizard.new(ReturningTeacher, session, params, returning_teacher_params).continue
      @returning_teacher = @wizard.object
      if params[:previous_branch_button]
        redirect_to new_registration_path(current_step: Registration.total_steps)
      end
      if @wizard.save
       
        #redirect to next paths
      else
        render :new
      end
  end

  private
   
  def returning_teacher_params
    params.require(:returning_teacher).permit(
    :primary_or_secondary,
    :current_step
    )
  end

end