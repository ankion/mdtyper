class Blog::PostApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :find_blog
  layout "blog_site"

  def find_blog
    case request.host
    when Rails.application.secrets.domain_name, nil
    else     
      if request.host.index(Rails.application.secrets.domain_name)
        @current_blog = Blog.find_by_subdomain(request.host.split('.').first)
      else
        @current_blog = Blog.find_by_fqdn(request.host)
      end

      if !@current_blog
        redirect_to Rails.application.secrets.domain_name
      end

    end  
  end

  def per_page
    @current_blog.per_page || 10
  end
end
