class AddEnableSocialButtonToBlogs < ActiveRecord::Migration
  def change
    add_column :blogs, :facebook_button, :bool, :default => false
    add_column :blogs, :twitter_button, :bool, :default => false
    add_column :blogs, :google_button, :bool, :default => false
  end
end
