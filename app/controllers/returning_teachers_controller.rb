class ReturningTeachersController < ApplicationController

  def new
    @wizard = ModelWizard.new(ReturningTeacher, session, params).start
    @returning_teacher = @wizard.object
  end

  def create
    @wizard = ModelWizard.new(ReturningTeacher, session, params, returning_teacher_params).continue
    @returning_teacher = @wizard.object
      
    if @wizard.save
      if @returning_teacher.primary_or_secondary == "primary"
        redirect_to new_primary_teacher_path(step: 0)
      else
        redirect to new_secondary_teacher_path(step: 0)
      end 
    else
      redirect_to new_returning_teacher_path(step: @returning_teacher.current_step)
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