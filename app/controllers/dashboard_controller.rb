class DashboardController < ApplicationController
  before_action :find_blog

  def find_blog
    @blog = Blog.find_by(:subdomain => params[:subdomain])
  end

  def index
    @posts = @blog.posts.all
  end
end
