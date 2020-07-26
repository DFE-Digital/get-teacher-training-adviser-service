class PagesController < ApplicationController
  def show
    render template: "pages/#{params[:page]}"
  end

  def privacy_policy
    policy_id = params[:id]

    @privacy_policy = if policy_id
                        ApiClient.get_privacy_policy(policy_id) #what if we can't find the policy?
                      else
                        ApiClient.get_latest_privacy_policy
                      end

    render template: "pages/privacy_policy"
  end
end
