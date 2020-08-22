class SitemapsController < ApplicationController
  def index
    @host = "#{request.protocol}#{request.host}"
    respond_to do |format|
      format.xml
    end
  end
end
