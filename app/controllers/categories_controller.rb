class CategoriesController < ApplicationController
  before_filter :authenticate_user!
  after_action :verify_authorized
  before_action :find_blog
  layout "dashboard_site"

  def find_blog
    @current_blog = current_user.blogs.find_by(:subdomain => params[:blog_id])
  end

  def index
    @categories = @current_blog.categories.all
    @category = @current_blog.categories.new
    authorize @category
  end

  def create
    @category = @current_blog.categories.new(secure_params)
    authorize @category
    if @category.save
      redirect_to blog_categories_path(@current_blog), :notice => "Category added."
    else
      redirect_to blog_categories_path(@current_blog), :notice => "Unable to add category."
    end
  end

  def destroy
    category = @current_blog.categories.find_by(:name => params[:id])
    authorize category
    if category.destroy
      redirect_to blog_categories_path(@current_blog), :notice => "Category removed."
    else
      redirect_to blog_categories_path(@current_blog), :notice => "Unable to remove category."
    end
  end

  def secure_params
    params.require(:category).permit(:name)
  end
end
