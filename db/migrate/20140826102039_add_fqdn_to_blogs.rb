class AddFqdnToBlogs < ActiveRecord::Migration
  def change
    add_column :blogs, :fqdn, :string, :unique => true
  end
end
