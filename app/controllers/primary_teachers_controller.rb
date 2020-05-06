class PrimaryTeachersController < ApplicationController

  def new
    @wizard = ModelWizard.new(PrimaryTeacher, session, params).start
    @primary_teacher = @wizard.object
  end

  def create
    @wizard = ModelWizard.new(PrimaryTeacher, session, params, primary_teacher_params).continue
    @primary_teacher = @wizard.object
  byebug
    if @wizard.save
      if @primary_teacher.attributes["uk_or_overseas"] == "uk"
        redirect_to new_overseas_teacher_path(step: 0)
      else
        redirect_to new_uk_teacher_path(step: 0)
      end
    else
      redirect_to new_primary_teacher_path(step: @primary_teacher.current_step)
    end
  end
   
  private
   
  def primary_teacher_params
    params.require(:primary_teacher).permit(
    :qualified_subject,
    :dob_day,
    :dob_month,
    :dob_year,
    :uk_or_overseas,
    :current_step,
    :stage
    )
  end

end