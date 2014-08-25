class AddDisqusKeyToBlogs < ActiveRecord::Migration
  def change
    add_column :blogs, :disqus_key, :string
  end
end
