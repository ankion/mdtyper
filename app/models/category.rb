class Category < ActiveRecord::Base
  belongs_to :blog
  has_many :post_categoryships, :dependent => :destroy
  has_many :posts, :through => :post_categoryships

  def to_param
    "#{name}"
  end
end
