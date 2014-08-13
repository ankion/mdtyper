class AddPostCategoryshipsCountToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :post_categoryships_count, :integer, :default => 0
  end
end
