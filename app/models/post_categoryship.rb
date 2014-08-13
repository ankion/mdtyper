class PostCategoryship < ActiveRecord::Base
  belongs_to :post
  belongs_to :category, :counter_cache => true
end
