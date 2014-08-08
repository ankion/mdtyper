class ChangePublishDateTypeInPosts < ActiveRecord::Migration
  def change
    change_column :posts, :publish_date, :datetime
  end
end
