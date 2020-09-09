class PagesController < ApplicationController
  rescue_from ActionView::MissingTemplate, with: :rescue_missing_template

  def home
    render template: "pages/home"
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
