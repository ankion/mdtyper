class Category < ActiveRecord::Base
  belongs_to :blog
  has_many :post_categoryships, :dependent => :destroy
  has_many :posts, :through => :post_categoryships
end
