class PagesController < ApplicationController
  def show
    render template: "pages/#{params[:page]}"
  end

  def session_expired
    render template: "pages/session_expired"
  end

  def privacy_policy
    policy_id = params[:id]

    @privacy_policy = if policy_id
                        session[:privacy_policy_id] = policy_id
                        ApiClient.get_privacy_policy(policy_id)
                      else
                        # this should be removed when we have url checking
                        ApiClient.get_latest_privacy_policy
                      end

    render template: "pages/privacy_policy"
  end
end
