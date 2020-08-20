class SitemapsController < ApplicationController
  def index
    @host = "#{request.protocol}#{request.host}"
    @steps = Base.descendants.map(&:to_s)
    respond_to do |format|
      format.xml
    end
  end
end
