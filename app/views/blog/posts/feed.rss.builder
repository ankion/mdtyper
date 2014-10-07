xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title @current_blog.title
    xml.description @current_blog.description
    xml.link site_posts_url

    for post in @posts
      xml.item do
        xml.title post.title
        xml.description markdown(post.content).html_safe
        xml.pubDate post.publish_date.to_s(:rfc822)
        xml.link site_post_url(post)
        xml.guid site_post_url(post)
      end
    end
  end
end
