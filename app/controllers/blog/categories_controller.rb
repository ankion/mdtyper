class Blog::CategoriesController < Blog::PostApplicationController
  def index
    @category = @current_blog.categories.find_by(:name => params[:id])
    @posts = @category.posts.publish.page(params[:page]).per(per_page)
    @categories = @current_blog.categories.all
    @tags = @current_blog.posts.tag_counts_on(:tags)

    render template: "blog/posts/categories"
  end
end
