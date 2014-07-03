class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.integer :user_id
      t.string :title
      t.string :subtitle
      t.text :description
      t.string :subdomain

      t.timestamps
    end
  end
end
