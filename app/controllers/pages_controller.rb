class PagesController < ApplicationController
  def show
    render template: "pages/#{params[:page]}"
  end

  def privacy_policy
    @privacy_policy = ApiClient.get_latest_privacy_policy
    render template: "pages/privacy_policy"
  end
end
