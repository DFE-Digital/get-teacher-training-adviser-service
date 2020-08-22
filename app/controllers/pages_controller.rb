class PagesController < ApplicationController
  def show
    render template: "pages/#{params[:page]}"
  end

  def privacy_policy
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
end
