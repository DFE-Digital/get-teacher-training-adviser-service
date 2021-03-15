class ApplicationController < ActionController::Base
  default_form_builder GOVUKDesignSystemFormBuilder::FormBuilder
  before_action :http_basic_authenticate
  before_action :set_api_client_request_id

  rescue_from ActionController::InvalidAuthenticityToken, with: :session_expired
  rescue_from ActionController::RoutingError, with: :render_not_found
  rescue_from GetIntoTeachingApiClient::ApiError, with: :handle_api_error

  def raise_not_found
    raise ActionController::RoutingError, "Not Found"
  end

private

  def set_api_client_request_id
    # The request_id is passed to the ApiClient via Thread.current
    # so we don't have to set it explicitly on every usage.
    GetIntoTeachingApiClient::Current.request_id = request.uuid
  end

  def handle_api_error(error)
    render_too_many_requests && return if error.code == 429

    raise
  end

  def render_too_many_requests
    render template: "errors/too_many_requests", status: :too_many_requests, layout: "application"
  end

  def render_not_found
    render template: "errors/not_found", status: :not_found, layout: "application"
  end

  def http_basic_authenticate
    return true if ENV["HTTPAUTH_USERNAME"].blank?

    authenticate_or_request_with_http_basic do |name, password|
      name == ENV["HTTPAUTH_USERNAME"].to_s &&
        password == ENV["HTTPAUTH_PASSWORD"].to_s
    end
  end

  def session_expired(exception)
    Raven.capture_exception(exception)
    redirect_to session_expired_path
  end
end
