class DashboardController < ApplicationController
  def index
    @blog = Blog.find_by_subdomain(params[:subdomain])
  end
end
