class UkTeachersController < ApplicationController

  def new
    @wizard = ModelWizard.new(UkTeacher, session, params).start
    @uk_teacher = @wizard.object
  end

  def create
    @wizard = ModelWizard.new(UkTeacher, session, params, uk_teacher_params).continue
    @uk_teacher = @wizard.object
      byebug
    if @wizard.save
      # completion
    else
      redirect_to new_uk_teacher_path(step: @uk_teacher.current_step)
    end
  end

  private
   
  def uk_teacher_params
    params.require(:uk_teacher).permit(
    :postcode,
    :address_line_1,
    :address_line_2,
    :current_step,
    :town_city,
    :email_opt_in,
    :privacy_policy,
    :confirmed,
    :current_step,
    :stage
    )
  end

end