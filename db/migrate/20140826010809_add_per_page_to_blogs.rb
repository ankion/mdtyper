class AddPerPageToBlogs < ActiveRecord::Migration
  def change
    add_column :blogs, :per_page, :integer, :default => 10
  end
end
