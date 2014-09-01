class Blog::PostsController < Blog::ApplicationController
  def index
    @posts = @current_blog.posts.publish.page(params[:page]).per(per_page)
    @categories = @current_blog.categories.all
  end

  def show
    @post = @current_blog.posts.publish.find(params[:id])
    @categories = @current_blog.categories.all
  end
end
