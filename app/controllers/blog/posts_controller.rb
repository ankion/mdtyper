class Blog::PostsController < Blog::PostApplicationController
  def index
    @posts = @current_blog.posts.publish.page(params[:page]).per(per_page)
    @categories = @current_blog.categories.all
    @tags = @current_blog.posts.tag_counts_on(:tags)
  end

  def feed
    @posts = @current_blog.posts.publish.page(params[:page]).limit(20)

    respond_to do |format|
      format.rss { render :layout => false }
    end
  end

  def show
    @post = @current_blog.posts.publish.find(params[:id])
    @categories = @current_blog.categories.all
    @tags = @current_blog.posts.tag_counts_on(:tags)
  end

  def tag_cloud
    @current_tags = params[:id].split(',')
    @posts = @current_blog.posts.tagged_with(@current_tags).publish.page(params[:page]).per(per_page)
    @categories = @current_blog.categories.all
    @tags = @current_blog.posts.tag_counts_on(:tags)
    @rel_tags = @current_blog.posts.tagged_with(@current_tags).tag_counts_on(:tags)

    render template: "blog/posts/categories"
  end
end
