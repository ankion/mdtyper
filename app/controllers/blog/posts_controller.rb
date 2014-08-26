class Blog::PostsController < ApplicationController
  before_filter :find_blog
  layout "blog_site"

  def find_blog
    case request.host
    when "mdwriter.dev", nil
    else     
      if request.host.index("mdwriter.dev")
        @current_blog = Blog.find_by_subdomain(request.host.split('.').first)
      #else
        #@current_blog = Blog.find_by_fqdn(request.host)
      end

      if !@current_blog
        redirect_to "mdwriter.dev"
      end

    end  
  end

  def per_page
    @current_blog.per_page || 10
  end

  def index
    @posts = @current_blog.posts.all.order('publish_date DESC').page(params[:page]).per(per_page)
    @categories = @current_blog.categories.all
  end

  def show
    @post = @current_blog.posts.find(params[:id])
    @categories = @current_blog.categories.all
  end
end
