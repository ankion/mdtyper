class DashboardController < ApplicationController
  before_action :find_blog
  layout "dashboard_site"

  def find_blog
    if params[:subdomain]
      @current_blog = current_user.blogs.find_by(:subdomain => params[:subdomain])
    else
      @current_blog = current_user.blogs.first
    end
  end

  def index
    if @current_blog.blank?
      redirect_to new_blog_path, :alert => "Create a blog first."
      return
    end
    @posts = @current_blog.posts.all
  end
end
