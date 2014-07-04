class PostsController < ApplicationController
  before_action :find_blog

  def find_blog
    @blog = Blog.find_by(:subdomain => params[:blog_id])
  end

  def new
    @post = @blog.posts.new
  end

  def create
    post = @blog.posts.new(secure_params)
    if post.save
      redirect_to dashboard_path(@blog), :notice => "Post added."
    else
      render :new
    end
  end

  def edit
    @post = @blog.posts.find(params[:id])
  end

  def update
    post = @blog.posts.find(params[:id])
    if post.update_attributes(secure_params)
      redirect_to dashboard_path(@blog), :notice => "Post updated."
    else
      render :edit
    end
  end

  def secure_params
    params.require(:post).permit(:publish_date, :title, :content)
  end
end
