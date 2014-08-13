class CreatePostCategoryships < ActiveRecord::Migration
  def change
    create_table :post_categoryships do |t|
      t.references :post, index: true
      t.references :category, index: true

      t.timestamps
    end
  end
end
