class ReturningTeachersController < ApplicationController

  def new
    @wizard = ModelWizard.new(ReturningTeacher, session, params).start
    @returning_teacher = @wizard.object
  end

  def create
    @wizard = ModelWizard.new(ReturningTeacher, session, params, returning_teacher_params).continue
      @returning_teacher = @wizard.object
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