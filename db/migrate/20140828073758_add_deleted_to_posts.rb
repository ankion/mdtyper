class AddDeletedToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :deleted, :bool, :default => false
  end
end
