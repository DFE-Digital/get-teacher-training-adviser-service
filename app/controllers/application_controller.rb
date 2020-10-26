class ApplicationController < ActionController::Base
  default_form_builder GOVUKDesignSystemFormBuilder::FormBuilder
  before_action :http_basic_authenticate

  rescue_from ActionController::InvalidAuthenticityToken, with: :session_expired
  rescue_from ActionController::RoutingError, with: :render_not_found

  def raise_not_found
    raise ActionController::RoutingError, "Not Found"
  end

private

  def render_not_found
    render template: "errors/not_found", status: :not_found
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
