class BlogsController < ApplicationController
  before_filter :authenticate_user!
  after_action :verify_authorized
  layout "dashboard_site"

  def index
    @blogs = current_user.blogs.all
    authorize Blog
  end

  def new
    @blog = current_user.blogs.new
    authorize @blog
  end

  def create
    @blog = current_user.blogs.new(secure_params)
    authorize @blog
    if @blog.save
      redirect_to dashboard_path(@blog), :notice => "Blog added."
    else
      render :new
    end
  end

  def show
    @blog = current_user.blogs.find_by(:subdomain => params[:id])
    authorize @blog
  end

  def edit
    @blog = current_user.blogs.find_by(:subdomain => params[:id])
    authorize @blog
  end

  def update
    blog = current_user.blogs.find_by(:subdomain => params[:id])
    authorize blog
    if blog.update_attributes(secure_params)
      redirect_to dashboard_path(blog.subdomain), :notice => "Blog updated."
    else
      redirect_to blogs_path, :alert => "Unable to update blog."
    end
  end

  def destroy
    blog = current_user.blogs.find_by(:subdomain => params[:id])
    authorize blog
    blog.destroy
    redirect_to blogs_path, :notice => "Blog deleted."
  end

  private

  def secure_params
    params.require(:blog).permit(:title, :subtitle, :description, :subdomain)
  end
end
