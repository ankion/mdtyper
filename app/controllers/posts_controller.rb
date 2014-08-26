class PostsController < ApplicationController
  before_action :find_blog
  layout "dashboard_site"

  def find_blog
    @current_blog = current_user.blogs.find_by(:subdomain => params[:blog_id])
  end

  def new
    @post = @current_blog.posts.new
    @categories = @current_blog.categories.all
  end

  def create
    post = @current_blog.posts.new(secure_params)
    if post.save
      redirect_to dashboard_path(@current_blog), :notice => "Post added."
    else
      render :new
    end
  end

  def edit
    @post = @current_blog.posts.find(params[:id])
    @categories = @current_blog.categories.all
  end

  def update
    post = @current_blog.posts.find(params[:id])
    if post.update_attributes(secure_params)
      redirect_to dashboard_path(@current_blog), :notice => "Post updated."
    else
      render :edit
    end
  end

  def secure_params
    params.require(:post).permit(:publish_date, :title, :permalink, :status, :content, :category_ids => [], :categories_attributes => [:id, :name])
  end
end
