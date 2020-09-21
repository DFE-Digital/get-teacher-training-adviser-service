class PagesController < ApplicationController
  PAGE_TEMPLATE_FILTER = %r{\A[a-zA-Z0-9][a-zA-Z0-9_\-/]*(\.[a-zA-Z]+)?\z}.freeze
  class InvalidTemplateName < RuntimeError; end

  rescue_from ActionView::MissingTemplate, InvalidTemplateName, with: :rescue_missing_template

  def show
    render template: page_template
  end

  def session_expired
    @page_title = "session expired"
    render template: "pages/session_expired"
  end

  def privacy_policy
    @page_title = "privacy policy"
    policy_id = params[:id]

    @privacy_policy = if policy_id
                        session[:privacy_policy_id] = policy_id
                        GetIntoTeachingApiClient::PrivacyPoliciesApi.new.get_privacy_policy(policy_id)
                      else
                        # this should be removed when we have url checking
                        GetIntoTeachingApiClient::PrivacyPoliciesApi.new.get_latest_privacy_policy
                      end

    render template: "pages/privacy_policy"
  end

private

  def page_template
    "pages/#{filtered_page_template}"
  end

  def filtered_page_template(page_param = :page)
    params[page_param].to_s.tap do |page|
      raise InvalidTemplateName if page !~ PAGE_TEMPLATE_FILTER
    end
  end

  def rescue_missing_template
    respond_to do |format|
      format.html do
        render \
          template: "errors/not_found",
          status: :not_found
      end

      format.all do
        render status: :not_found, body: nil
      end
    end
  end
end
