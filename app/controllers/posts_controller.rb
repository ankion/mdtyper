class PostsController < ApplicationController
  before_filter :authenticate_user!
  after_action :verify_authorized
  before_action :find_blog
  layout "dashboard_site"

  def find_blog
    @current_blog = current_user.blogs.find_by(:subdomain => params[:blog_id])
    @current_blog.filepicker_key = ENV['FILEPICKER_KEY'] if @current_blog.filepicker_key.blank?
  end

  def new
    @post = @current_blog.posts.new
    authorize @post
    @categories = @current_blog.categories.all
  end

  def create
    @post = @current_blog.posts.new(secure_params)
    authorize @post
    if @post.save
      redirect_to edit_blog_post_path(@current_blog, @post)
    else
      redirect_to dashboard_path(@current_blog), :notice => "Unable to add post."
    end
  end

  def edit
    @post = @current_blog.posts.find(params[:id])
    authorize @post
    @categories = @current_blog.categories.all
  end

  def update
    @post = @current_blog.posts.find(params[:id])
    authorize @post
    if @post.update_attributes(secure_params)
      redirect_to dashboard_path(@current_blog), :notice => "Post updated."
    else
      render :edit
    end
  end

  def destroy
    post = @current_blog.posts.find(params[:id])
    authorize post
    post.deleted = true
    if post.save
      redirect_to dashboard_path(@current_blog), :notice => "Post destroyed. #{ActionController::Base.helpers.link_to 'Undo', revert_blog_post_path(:id => post.id)}"
    else
      redirect_to dashboard_path(@current_blog), :notice => "Unable to destroy post."
    end
  end

  def revert
    post = @current_blog.posts.unscoped.find(params[:id])
    authorize post, :destroy?
    post.deleted = false
    if post.save
      redirect_to dashboard_path(@current_blog), :notice => "Post reverted."
    else
      redirect_to dashboard_path(@current_blog), :notice => "Unable to revert post."
    end
  end

  def preview
    post = @current_blog.posts.find(params[:id])
    authorize post, :index?
    render layout: false
  end

  def secure_params
    params.require(:post).permit(:publish_date, :title, :permalink, :status, :content, :category_ids => [], :categories_attributes => [:id, :name])
  end
end
