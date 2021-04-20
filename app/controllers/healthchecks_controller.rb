class HealthchecksController < ApplicationController
  def show
    @healthcheck = Healthcheck.new
    Rails.logger.info("HealthCheck: #{@healthcheck.to_h}")
    render json: @healthcheck
  end

protected

  def authenticate?
    false
  end
end
