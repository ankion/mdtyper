class AddFilepickerKeyToBlogs < ActiveRecord::Migration
  def change
    add_column :blogs, :filepicker_key, :string
  end
end
