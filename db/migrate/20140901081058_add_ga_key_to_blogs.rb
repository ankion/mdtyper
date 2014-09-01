class AddGaKeyToBlogs < ActiveRecord::Migration
  def change
    add_column :blogs, :ga_key, :string
  end
end
