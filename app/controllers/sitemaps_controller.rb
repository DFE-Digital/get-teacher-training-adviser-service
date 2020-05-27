class SitemapsController < ApplicationController
  skip_before_action :http_basic_authenticate

  def index
    @host = "#{request.protocol}#{request.host}"
    @steps = StepFactory::STEP_NAMES
    respond_to do |format|
      format.xml
    end
  end
end