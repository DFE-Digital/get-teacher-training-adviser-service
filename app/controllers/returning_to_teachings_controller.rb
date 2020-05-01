class ReturningToTeachingsController < ApplicationController

  def new
    @returning_to_teaching = ReturningToTeaching.new
  end

  def create
    @returning_to_teaching = ReturningToTeaching.new(returning_to_teaching_params)
    if @returning_to_teaching.valid?
      session[:registration].merge!(@returning_to_teaching.attributes)
      if @returning_to_teaching.returning_to_teaching
        redirect_to new_primary_or_secondary_path
      else
        # redirect to another path
      end
    else
      render :new
    end
  end

  private

  def returning_to_teaching_params
    params.require(:returning_to_teaching).permit(
      :returning_to_teaching
    )
  end
  
end