class Blog::CategoriesController < Blog::PostApplicationController
  def index
    @category = @current_blog.categories.find_by(:name => params[:id])
    @posts = @category.posts.publish.page(params[:page]).per(per_page)
    @categories = @current_blog.categories.all

    render template: "blog/posts/index"
  end
end
